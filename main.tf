

resource "aws_elastic_beanstalk_application" "wordpressapp" {
  name        = var.applicationname
}

resource "aws_elastic_beanstalk_environment" "wordpressenv" {
  name                = var.env
  application         = aws_elastic_beanstalk_application.wordpressapp.name
  solution_stack_name = var.solution_stack_name
  
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = var.ec2key
  }
  
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.ec2_eb_profile.name
  }
}

# Create instance profile
resource "aws_iam_instance_profile" "ec2_eb_profile" {
  name = "${var.applicationname}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "ec2_role" {
  name               = "${var.applicationname}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier",
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker",
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier",
    "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  ]

  inline_policy {
    name   = "${var.applicationname}-application-permissions"
    policy = data.aws_iam_policy_document.permissions.json
  }
}
