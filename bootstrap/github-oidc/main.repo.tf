resource "github_repository" "this" {
  name                        = var.repository_name
  visibility                  = "public"
  has_downloads               = true
  has_wiki                    = true
  has_issues                  = true
  has_projects                = true
  vulnerability_alerts        = true
  allow_merge_commit          = false
  squash_merge_commit_message = "PR_BODY"
  squash_merge_commit_title   = "PR_TITLE"
  merge_commit_title          = "MERGE_MESSAGE"
  merge_commit_message        = "PR_TITLE"
  delete_branch_on_merge      = true
}

resource "github_repository_environment" "prod" {
  repository  = github_repository.this.name
  environment = "prod"
}

resource "github_actions_environment_secret" "test_secret" {
  for_each        = local.environment_secrets
  repository      = github_repository.this.name
  environment     = github_repository_environment.prod.environment
  secret_name     = each.key
  plaintext_value = each.value
}
