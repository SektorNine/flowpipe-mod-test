variable "database" {
  type = connection.steampipe
  description = "The database connection to use."
  default = connection.steampipe.default
}

variable "notifier" {
  type = notifier
  description = "The notifier to use."
  default = notifier.default
}

variable "some_json" {
  type = string
  description = "Some JSON data."
  default = <<EOT
{
  "key": "value",
  "array": [1, 2, 3],
  "object": {
    "key": "value"
  }
}
EOT
}

variable "complex" {
  type = object({
    name  = string
    ages  = list(number)
    meta  = object({
      name    = string
      ages    = list(number)
      is_true = bool
    })
  })
  description = "A complex object."
  default = {
    name = "complex"
    ages = [1, 2, 3]
    meta = {
      name = "meta"
      ages = [4, 5, 6]
      is_true = true
    }
  }
}

variable "approvers" {
  type = list(notifier)
  description = "A list of approvers."
  default = [notifier.default]
}

