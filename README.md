# Étude comparative des types d'instances EC2

Pour répondre au cahier des charges, nous avons réalisé une étude comparative des types d'instances EC2 disponibles en Europe, en nous basant sur les contraintes suivantes :

- L'instance doit avoir entre 1 et 2 vCPUs.
- L'instance doit avoir 2 Go de RAM.
- L'instance doit être déployée en Europe.
- L'instance doit être la moins coûteuse possible.

Voici toutes les instances correspondantes au spécifications données dans le cahier des charges et dans AWS :


| Instance Type    | Prix par heure (USD) | vCPUs | Mémoire (GiB) | Stockage                     | Bande passante réseau     | Localisation     |
|------------------|----------------------|-------|---------------|------------------------------|---------------------------|------------------|
| t2.small         | 0,0250               | 1     | 2 GiB         | EBS uniquement               | Faible à modéré            | Irlande          |
| t2.small         | 0,0260               | 1     | 2 GiB         | EBS uniquement               | Faible à modéré            | Londres          |
| t2.small         | 0,0268               | 1     | 2 GiB         | EBS uniquement               | Faible à modéré            | Francfort        |
| t2.small         | 0,0264               | 1     | 2 GiB         | EBS uniquement               | Faible à modéré            | Europe/Espagne   |
| c6g.medium       | 0,0365               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 10 gigabits        | Zurich           |
| c6g.medium       | 0,0365               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 10 gigabits        | Stockholm        |
| c6g.medium       | 0,0365               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 10 gigabits        | Irlande          |
| c6g.medium       | 0,0388               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 10 gigabits        | Francfort        |
| c6g.medium       | 0,0388               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 12500 mégabits     | Irlande          |
| c6g.medium       | 0,0404               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 10 gigabits        | Londres          |
| c6g.medium       | 0,0404               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 10 gigabits        | Milan            |
| c6g.medium       | 0,0405               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 10 gigabits        | Europe/Paris     |
| c6g.medium       | 0,0427               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 10 gigabits        | Zurich           |
| c7g.medium       | 0,0387               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 12500 mégabits     | Stockholm        |
| c7g.medium       | 0,0388               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 12500 mégabits     | Irlande          |
| c7g.medium       | 0,0412               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 12500 mégabits     | Francfort        |
| c7g.medium       | 0,0428               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 12500 mégabits     | Milan            |
| c7g.medium       | 0,0429               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 12500 mégabits     | Londres          |
| c6gd.medium      | 0,0416               | 1     | 2 GiB         | 1 disque SSD NVMe 59         | Jusqu’à 10 gigabits        | Stockholm        |
| c6gd.medium      | 0,0436               | 1     | 2 GiB         | 1 disque SSD NVMe 59         | Jusqu’à 10 gigabits        | Zurich           |
| c6gd.medium      | 0,0436               | 1     | 2 GiB         | 1 disque SSD NVMe 59         | Jusqu’à 10 gigabits        | Europe/Espagne   |
| c6gd.medium      | 0,0436               | 1     | 2 GiB         | 1 disque SSD NVMe 59         | Jusqu’à 10 gigabits        | Irlande          |
| c6gd.medium      | 0,0445               | 1     | 2 GiB         | 1 disque SSD NVMe 59         | Jusqu’à 10 gigabits        | Francfort        |
| c6gd.medium      | 0,0460               | 1     | 2 GiB         | 1 disque SSD NVMe 59         | Jusqu’à 10 gigabits        | Londres          |
| c6gn.medium      | 0,0465               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 25 gigabits        | Stockholm        |
| c6gn.medium      | 0,0488               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 25 gigabits        | Irlande          |
| c6gn.medium      | 0,0493               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 25 gigabits        | Francfort        |
| c6gn.medium      | 0,05125              | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 25 gigabits        | Londres          |
| c6gn.medium      | 0,0516               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 25 gigabits        | Milan            |
| c7a.medium       | 0,0525               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 12500 mégabits     | Irlande          |
| c7gd.medium      | 0,0515               | 1     | 2 GiB         | 1 disque SSD NVMe 59         | Jusqu’à 12500 mégabits     | Europe/Espagne   |
| c7gd.medium      | 0,0515               | 1     | 2 GiB         | 1 disque SSD NVMe 59         | Jusqu’à 12500 mégabits     | Irlande          |
| c7gd.medium      | 0,0525               | 1     | 2 GiB         | 1 disque SSD NVMe 59         | Jusqu’à 12500 mégabits     | Francfort        |
| c7a.medium       | 0,05494              | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 12500 mégabits     | Stockholm        |
| c7a.medium       | 0,05506              | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 12500 mégabits     | Irlande          |
| c7a.medium       | 0,05796              | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 12500 mégabits     | Europe/Espagne   |
| c7a.medium       | 0,05857              | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 12500 mégabits     | Francfort        |
| c7gn.medium      | 0,0705               | 1     | 2 GiB         | EBS uniquement               | Jusqu’à 25 gigabits        | Irlande          |

| Instance Type    | Prix par heure (USD) | vCPUs | Mémoire (GiB) | Stockage       | Bande passante réseau | Localisation   |
|------------------|----------------------|-------|---------------|----------------|-----------------------|----------------|
| t4g.small        | 0,0172               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Stockholm      |
| t4g.small        | 0,0184               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Irlande        |
| t4g.small        | 0,0184               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Espagne        |
| t4g.small        | 0,0188               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Paris          |
| t4g.small        | 0,0188               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Irlande        |
| t4g.small        | 0,0192               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Milan          |
| t4g.small        | 0,0192               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Francfort      |
| t4g.small        | 0,0211               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Zurich         |
| t3a.small        | 0,0204               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Irlande        |
| t3a.small        | 0,0212               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Paris          |
| t3a.small        | 0,0212               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Irlande        |
| t3a.small        | 0,0216               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Francfort      |
| t3a.small        | 0,0216               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Milan          |
| t3.small         | 0,0216               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Stockholm      |
| t3.small         | 0,0228               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Espagne        |
| t3.small         | 0,0228               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Irlande        |
| t3.small         | 0,0236               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Paris          |
| t3.small         | 0,0236               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Irlande        |
| t3.small         | 0,0240               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Milan          |
| t3.small         | 0,0240               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Francfort      |
| t3.small         | 0,0264               | 2     | 2 GiB         | EBS uniquement | Jusqu’à 5 gigabits     | Zurich         |

Nous avons identifié plusieurs types d'instances EC2 qui respectent ces contraintes dans les régions d'Europe suivantes : Irlande, Francfort, Milan, Paris, Londres, et Stockholm.





## Région : Europe (Irlande)
- **t4g.small** : 0,0184 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement
- **t3a.small** : 0,0204 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement
- **t3.small** : 0,0228 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement

## Région : Europe (Francfort)
- **t4g.small** : 0,0192 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement
- **t3a.small** : 0,0216 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement
- **t3.small** : 0,0240 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement

## Région : Europe (Milan)
- **t4g.small** : 0,0192 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement
- **t3a.small** : 0,0216 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement
- **t3.small** : 0,0240 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement

## Région : Europe (Paris)
- **t4g.small** : 0,0188 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement
- **t3a.small** : 0,0212 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement
- **t3.small** : 0,0236 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement

## Région : Europe (Londres)
- **t4g.small** : 0,0184 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement
- **t3a.small** : 0,0204 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement
- **t3.small** : 0,0228 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement

## Région : Europe (Stockholm)
- **t4g.small** : 0,0172 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement
- **t3a.small** : 0,0216 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement
- **t3.small** : 0,0216 USD/h, 2 vCPUs, 2 Go RAM, EBS uniquement

### Conclusion
Parmi les options disponibles, l'instance **t4g.small** dans la région **Stockholm** est la moins coûteuse, avec un coût horaire de 0,0172 USD. Elle respecte toutes les contraintes du cahier des charges en offrant 2 vCPUs, 2 Go de RAM, et en étant déployée en Europe.
