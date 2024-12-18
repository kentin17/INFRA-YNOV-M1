# Document de Conformité aux Contraintes du Projet

## 1. Contraintes liées à la haute disponibilité (réseau)
- **Contrainte** : Assurer la répartition des ressources sur les trois zones de disponibilité (AZ).
- **Mise en œuvre** :
  - Les sous-réseaux ont été configurés dans les 3 AZ disponibles.
  - L'ALB (Application Load Balancer) utilise les sous-réseaux publics dans les trois AZ pour distribuer le trafic.
  - L'Auto Scaling Group est configuré pour déployer des instances EC2 dans ces 3 AZ.

---

## 2. Contraintes de nomenclature des ressources
- **Contrainte** : Utiliser une nomenclature claire et standardisée pour toutes les ressources.
- **Mise en œuvre** :
  - La nomenclature est basée sur le format `<username>-<tp_directory>-<resource>`.
  - Exemple : `qvos-tp09-ex01-nextcloud`, `qvos-tp09-ex01-alb`.

---

## 3. Contraintes liées à l’authentification SSH sur les instances EC2
- **Contrainte** : Utiliser des paires de clés SSH sécurisées.
- **Mise en œuvre** :
  - Une paire de clés distincte est utilisée pour chaque type d'instance (Bastion, Nextcloud).
  - Les clés publiques sont spécifiées dans les ressources `aws_key_pair`.

---

## 4. Contraintes liées à l’accessibilité (SSH) du bastion
- **Contrainte** : Restreindre l'accès SSH au bastion à une IP spécifique.
- **Mise en œuvre** :
  - Le Security Group du bastion autorise uniquement l'IP publique de l'entreprise ( ip pub de cloud9 ) à se connecter en ssh au bastion

---

## 5. Contraintes liées à l’accessibilité (SSH) des instances Nextcloud
- **Contrainte** : L'accès SSH aux instances Nextcloud doit être limité au bastion.
- **Mise en œuvre** :
  - Le Security Group des instances Nextcloud autorise uniquement les connexions SSH provenant du bastion.

---

## 6. Contraintes liées à l’utilisation du service EC2 Instance Connect
- **Contrainte** : Interdire l'utilisation d'EC2 Instance Connect.
- **Mise en œuvre** :
  - Aucun accès EC2 Instance Connect n'a été configuré pour les instances.

---

## 7. Contraintes liées à la sécurité des fichiers stockés sur le système de fichiers partagé
- **Contrainte** : Chiffrer les données stockées dans EFS.
- **Mise en œuvre** :
  - Le système de fichiers EFS est configuré avec un chiffrement au repos via AWS KMS.

---

## 8. Contraintes liées à l’accessibilité du système de fichiers partagé
- **Contrainte** : Restreindre l'accès à EFS uniquement aux instances Nextcloud.
- **Mise en œuvre** :
  - Le Security Group d'EFS autorise uniquement les connexions provenant du Security Group des instances Nextcloud.

---

## 9. Contraintes liées à la haute disponibilité du système de fichiers partagé
- **Contrainte** : Garantir une haute disponibilité pour EFS.
- **Mise en œuvre** :
  - EFS est déployé avec des points de montage dans les 3 AZ pour assurer la redondance.

---

## 10. Contraintes liées à l’accessibilité de la base de données
- **Contrainte** : Restreindre l'accès à la base de données uniquement aux instances Nextcloud.
- **Mise en œuvre** :
  - Le Security Group de RDS autorise les connexions uniquement depuis le Security Group des instances Nextcloud.

---

## 11. Contraintes liées à la haute disponibilité de la base de données
- **Contrainte** : Utiliser une base de données avec un failover automatique.
- **Mise en œuvre** :
  - Amazon RDS est configuré avec Multi-AZ pour permettre un basculement automatique en cas de panne d'une AZ.

---

## 12. Contraintes liées à l’accessibilité de l’application Nextcloud
- **Contrainte** : Restreindre l'accès à l'application via l'ALB.
- **Mise en œuvre** :
  - Le trafic est redirigé vers les instances Nextcloud uniquement via l'ALB.
  - Le Security Group de l'ALB autorise les connexions HTTP/HTTPS depuis Internet.

---

## 13. Contraintes liées à la haute disponibilité de l’application
- **Contrainte** : Assurer la haute disponibilité de l'application Nextcloud.
- **Mise en œuvre** :
  - Un Auto Scaling Group (ASG) gère dynamiquement le nombre d'instances Nextcloud.
  - Les instances sont déployées dans les trois AZ pour garantir la redondance.

---

## 14. Contraintes liées à l’élasticité de l’application
- **Contrainte** : Prévoir l'ajout ou la suppression d'instances en fonction de la charge.
- **Mise en œuvre** :
  - L'Auto Scaling Group est prêt pour gérer dynamiquement les instances.

---

## 15. Contraintes liées à la méthode d’authentification des instances EC2 auprès des API AWS
- **Contrainte** : Utiliser un profil IAM pour les instances.
- **Mise en œuvre** :
  - Les instances Nextcloud utilisent un profil IAM avec un rôle associé pour accéder aux services AWS.

---

## 16. Contraintes liées aux permissions entre Nextcloud et le Bucket S3
- **Contrainte** : Restreindre les permissions au strict nécessaire.
- **Mise en œuvre** :
  - Le rôle IAM des instances Nextcloud inclut les actions minimales nécessaires pour accéder au bucket S3 (GetObject, PutObject, DeleteObject).

---

## 17. Contraintes liées aux permissions sur le bucket S3
- **Contrainte** : Sécuriser le bucket S3.
- **Mise en œuvre** :
  - Une bucket policy restreint l'accès au bucket S3 uniquement aux instances Nextcloud et à l'utilisateur Terraform.
  - Le chiffrement côté serveur (SSE-S3) est activé sur le bucket.
