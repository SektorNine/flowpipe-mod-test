pipeline "test_single_response" {
  title = "Test Single Response"

  param "notifier" {
    type = notifier
    default = var.notifier
  }

  step "input" "question" {
    type = "button"
    prompt = "Do you approve?"

    option "yes" {
      value = "yes"
      label = "Yes"
      style = "ok"
    }
    option "no" {
      value = "no"
      label = "No"
      style = "alert"
    }

    notifier = param.notifier
  }

  step "message" "answer" {
    notifier = param.notifier
    text     = step.input.question.value
  }
}

pipeline "message_me" {
  title = "Message Me"

  param "notifier" {
    type = notifier
    default = var.notifier
  }

  step "message" "answer" {
    notifier = param.notifier
    text     = "HELLO!"
  }
}