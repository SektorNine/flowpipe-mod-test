pipeline "boop" {
  title = "Boop"

  param "notifier" {
    type = notifier
    default = var.notifier
  }

  step "transform" "json" {
    value = var.some_json
  }

  step "transform" "complex" {
    value = var.complex
  }

  output "results" {
    value = {
      json = step.transform.json.value
      complex = step.transform.complex.value
      db = var.database
      approvers = var.approvers
      notifier = param.notifier
    }
  }
}