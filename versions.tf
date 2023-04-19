terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.4.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.3.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.0"
    }

 
  }

  required_version = ">= 0.14"
}

