pipeline "test_single_response" {
  title = "Test Single Response"

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

    notifier = notifier.workspace_owners
  }

  step "message" "answer" {
    notifier = notifier.workspace_owners
    text     = step.input.question.value
  }
}