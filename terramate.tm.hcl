terramate {
  required_version = "~> 0.11"

  config {
    cloud {
      organization = "matt-FFFFFF"
    }
    run {
      env {
        TF_PLUGIN_CACHE_DIR = "${terramate.root.path.fs.absolute}/.terraform-cache-dir"
      }
    }
    experiments = [
      "outputs-sharing",
      "scripts",
    ]
  }
}
