terraform {
  required_providers {
    concourse = {
      source  = "terraform-provider-concourse/concourse"
      version = "~> 7.0"
    }
  }
}

provider "concourse" {
  url  = var.concourse_url
  team = "main"

  username = var.concourse_username
  password = var.concourse_password
}

resource "concourse_team" "pages" {
  team_name = "pages"

  members = [
    "group:oauth:concourse.pages"
  ]

}
