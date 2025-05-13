resource "aws_autoscaling_group" "ec2_asg" {
  name = "ec2_asg"

  min_size = 1
  max_size = 3
  desired_capacity = 2

  target_group_arns = [aws_lb_target_group.alb_ec2_tg.arn]
  vpc_zone_identifier = aws_subnet.private_subnet[*].id

  launch_template {
    id = aws_launch_template.ec2_launch_template.id
    version = "$Latest"
  }
  health_check_type = "EC2"
  

}