module "ecs_task_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 3.8.0"

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]

  create_role = true

  role_name         = "ecsTaskRole-${local.namespace}"
  role_requires_mfa = false

  custom_role_policy_arns = [
    aws_iam_policy.run_task.arn,
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  ]

  tags = local.default_tags
}

resource "aws_iam_policy" "run_task" {
  name        = "ECSRunTask-${local.namespace}"
  path        = "/"
  description = "Allows run task on API instance"

  policy = data.template_file.run_task_policy.rendered
}

data "template_file" "run_task_policy" {
  template = file("${path.module}/templates/run_task_policy.json.tpl")

  vars = {
    resource = regex(".*:", aws_ecs_task_definition.ecs_task_definition.arn)
  }
}
