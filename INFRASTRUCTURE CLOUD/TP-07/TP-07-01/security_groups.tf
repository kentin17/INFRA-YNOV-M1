# Security Group for Bastion Instance (Public)
resource "aws_security_group" "bastion_sg" {
  name        = "${local.name}-bastion-sg"
  description = "Allow SSH access to bastion from company IP or Cloud9"
  vpc_id      = aws_vpc.main.id

  # Allow SSH only from specified public IP
  ingress {
    description = "Allow SSH access from trusted IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["13.38.55.234/32"] # Replace with actual trusted IP
  }

  # Allow all outbound traffic from Bastion
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${local.name}-bastion-sg" }
}

# Security Group for EFS allowing access only from Nextcloud instances
resource "aws_security_group" "efs_sg" {
  name        = "${local.name}-efs-sg"
  description = "Allow NFS access to EFS from Nextcloud instances"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow NFS access from Nextcloud instances"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.nextcloud_sg.id]
  }

  # Allow all outbound traffic from EFS
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${local.name}-efs-sg" }
}

# Security Group for Nextcloud Instance (Private)
resource "aws_security_group" "nextcloud_sg" {
  name        = "${local.name}-nextcloud-sg"
  description = "Allow SSH access to Nextcloud only from the bastion instance"
  vpc_id      = aws_vpc.main.id

  # Allow SSH only from Bastion instance
  ingress {
    description     = "Allow SSH access from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  # Allow HTTP traffic from ALB
  ingress {
    description     = "Allow HTTP traffic from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Allow all outbound traffic from Nextcloud instances
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${local.name}-nextcloud-sg" }
}

# Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "${local.name}-rds-sg"
  description = "Allow access to RDS from Nextcloud instances"
  vpc_id      = aws_vpc.main.id

  # Allow MySQL connections from Nextcloud instances
  ingress {
    description     = "Allow MySQL access from Nextcloud instances"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.nextcloud_sg.id]
  }

  # Allow all outbound traffic from RDS
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${local.name}-rds-sg" }
}

# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "${local.name}-alb-sg"
  description = "Allow HTTP and HTTPS traffic to ALB"
  vpc_id      = aws_vpc.main.id

  # Allow HTTP traffic from the internet
  ingress {
    description = "Allow HTTP traffic from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["$CLOUD9_IP"]
  }

  # Allow HTTPS traffic from the internet
  ingress {
    description = "Allow HTTPS traffic from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic from ALB
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${local.name}-alb-sg" }
}
