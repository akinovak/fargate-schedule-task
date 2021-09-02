terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.10.0"
    }
    template = {
      source = "hashicorp/template"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0.0"
    }
  }
}
