pipeline "test_single_response" {
  title = "Test Single Response"

  step "input" "question" {
    type = "button"
    prompt = "Do you approve?"

    option "yes" {}
    option "no" {}

    notifier = notifier.default
  }

  step "message" "answer" {
    notifier = notifier.default
    text     = step.input.question.value
  }
}