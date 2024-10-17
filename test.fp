trigger "query" "simple" {
  title = "Simple"

  enabled  = true
  database = var.database
  sql = local.query

  capture "insert" {
    pipeline = pipeline.send_list
    args = {
      items = self.inserted_rows
    }
  }
}

trigger "query" "with_delay" {
  title = "With Delay"

  enabled  = true
  database = var.database
  sql = local.query

  capture "insert" {
    pipeline = pipeline.get_input
    args = {
      items = self.inserted_rows
    }
  }
}

pipeline "send_list" {
  title = "Send List"
  
  param "items" {
    type = list(object({
      name        = string
      arn         = string
      region      = string
      account_id  = string
      conn        = string
    }))
  }

  param "notifier" {
    type = notifier
    default = var.notifier
  }

  step "transform" "build_string" {
    value = "${length(param.items)} items: ${join(", ", [for item in param.items : item.name])}"
  }

  step "message" "send" {
    text     = "Buckets without tags: ${step.transform.build_string.value}"
    notifier = param.notifier
  }
}

pipeline "get_input" {
  title = "Get Input"

  param "items" {
    type = list(object({
      name        = string
      arn         = string
      region      = string
      account_id  = string
      conn        = string
    }))
  }

  step "transform" "build_string" {
    value = "${length(param.items)} items: ${join(", ", [for item in param.items : item.name])}"
  }

  step "input" "delay" {
    type   = "button"
    prompt = "This is a delay for purposes of pausing pipeline; respond after it's paused to attempt to resume."

    notifier = var.notifier

    option "Continue" {}
    option "Yes" {}
  }

  step "transform" "do_nothing" {
    value = "${step.input.delay.value}"
  }
}