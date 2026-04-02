# Innovatech Chile - Infraestructura AWS con Terraform

## Descripción
Este proyecto corresponde a la implementación de una infraestructura en AWS automatizada mediante **Terraform**, diseñada para desplegar una arquitectura de tres capas compuesta por **Frontend, Backend y Data**.

La solución considera buenas prácticas de infraestructura como código (IaC), separando los recursos en módulos lógicos como red, seguridad, cómputo y variables de configuración, permitiendo una administración clara, escalable y reutilizable.

La infraestructura está orientada a soportar el sistema **Innovatech Solutions**, desplegando instancias EC2 dentro de subredes públicas y privadas, con conectividad segura y controlada.

---

## Orden
La estructura del proyecto se encuentra organizada de la siguiente forma:

```bash
infra/
├── main.tf
├── variables.tf
├── network.tf
├── security.tf
├── compute.tf
├── launch_templates.tf
├── outputs.tf
├── terraform.tfvars
├── userdata/
│   ├── front.sh
│   ├── back.sh
│   └── data.sh
```

### Orden de ejecución recomendado
1. `terraform init`
2. `terraform plan`
3. `terraform apply`

Para eliminar la infraestructura:

```bash
terraform destroy
```

---

## Requisitos
Antes de ejecutar el proyecto debes tener instalado lo siguiente:

- **Terraform**
- **AWS CLI**
- Cuenta activa en **AWS Academy / AWS**
- Credenciales configuradas con:

```bash
aws configure
```

- Key Pair creada en AWS EC2
- Permisos para:
  - VPC
  - EC2
  - Security Groups
  - NAT Gateway
  - Internet Gateway

Verificar instalación:

```bash
terraform version
aws --version
```

---

## Flujo de uso
El flujo general del proyecto es el siguiente:

1. Terraform crea la **VPC**
2. Se generan las **subredes pública y privada**
3. Se configura el **Internet Gateway**
4. Se despliega el **NAT Gateway**
5. Se crean los **Security Groups**
6. Se levantan las instancias:
   - EC2 Frontend
   - EC2 Backend
   - EC2 Data
7. Se ejecutan los scripts de `userdata`
8. El frontend consume el backend
9. El backend se comunica con data / base de datos

---

## ¿Qué despliega este proyecto?
Este proyecto despliega la siguiente infraestructura en AWS:

- 1 **VPC**
- 1 **Subred pública**
- 1 **Subred privada**
- 1 **Internet Gateway**
- 1 **NAT Gateway**
- 3 **Instancias EC2**
  - Frontend
  - Backend
  - Data
- Security Groups
- Route Tables
- IP pública para acceso al frontend

Arquitectura lógica:

```text
Usuario
   ↓
EC2 Frontend (Subred pública)
   ↓
EC2 Backend (Subred privada)
   ↓
EC2 Data / Base de datos (Subred privada)
```

---

## Diagrama

A continuación se presenta el diagrama de arquitectura desplegada en AWS mediante Terraform:

![Diagrama de arquitectura AWS](images/Diagrama%20AWS.png)

## Mejores prácticas
Este proyecto aplica las siguientes buenas prácticas:

- Infraestructura como código con Terraform
- Separación por archivos según responsabilidad
- Variables reutilizables en `variables.tf`
- Configuración externa mediante `terraform.tfvars`
- Uso de subredes públicas y privadas
- Separación de frontend, backend y data
- Automatización mediante `userdata scripts`
- Seguridad mediante `security groups`
- Código mantenible y escalable

---

## ¿Cómo extender este proyecto?
Este proyecto puede crecer fácilmente agregando nuevos componentes, por ejemplo:

- **Load Balancer (ALB)**
- **Auto Scaling Group**
- **RDS para base de datos**
- **S3 para almacenamiento**
- **CloudWatch para monitoreo**
- **IAM Roles**
- **Route 53 + dominio**
- **HTTPS con ACM**
- **Docker + ECS**

Ejemplo de mejora futura:

```text
Usuario
   ↓
Load Balancer
   ↓
Auto Scaling Frontend
   ↓
Auto Scaling Backend
   ↓
RDS / EC2 Data
```

---