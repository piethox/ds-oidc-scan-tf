resource "aws_ecs_cluster" "grp2-chat-oidc" {
  name = "grp2-chat-oidc-cluster"
}

resource "aws_ecs_task_definition" "grp2-oidc-app" {
  family = "grp2-oidc-app-td"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = "512"
  memory = "1024"
  execution_role_arn = "arn:aws:iam::255945442255:role/ecsTaskExecutionRole"
  container_definitions = file("ecs-td-container-definition.json")
}

resource "aws_security_group" "ecs-sg" {
  vpc_id = var.vpc_id
  name = "grp2-iodc-sg"
  
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_ecs_service" "grp2-chat-service" {
  name = "grp2-chat-app-service"
  cluster = aws_ecs_cluster.grp2-chat-oidc.id
  task_definition = aws_ecs_task_definition.grp2-oidc-app.arn
  launch_type = "FARGATE"
  depends_on = [ aws_security_group.ecs-sg ]
  desired_count = 1
  
  network_configuration {
    subnets = var.subnets
    security_groups = [aws_security_group.ecs-sg.id]
    assign_public_ip = true
  }
}