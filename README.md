# Webiny [![Version](https://img.shields.io/badge/version-latest-fa5723)](https://github.com/stackblaze-templates/webiny) [![Maintained by StackBlaze](https://img.shields.io/badge/maintained%20by-StackBlaze-blue)](https://stackblaze.com) [![Weekly Updates](https://img.shields.io/badge/updates-weekly-green)](https://github.com/stackblaze-templates/webiny/actions) [![Deploy on StackBlaze](https://img.shields.io/badge/Deploy%20on-StackBlaze-orange)](https://stackblaze.com)

<p align="center"><img src="logo.png" alt="webiny" width="120"></p>

An open-source serverless headless CMS with page builder, file manager, form builder, and a plugin-based architecture.

> **Credits**: Built on [Webiny](https://webiny.com) by [Webiny](https://github.com/webiny). All trademarks belong to their respective owners.

## Local Development

See [Webiny docs](https://www.webiny.com/docs) for setup. Webiny typically deploys to AWS but can run locally for development.

## Deploy on StackBlaze

[![Deploy on StackBlaze](https://img.shields.io/badge/Deploy%20on-StackBlaze-orange)](https://stackblaze.com)

This template includes a `stackblaze.yaml` for one-click deployment on [StackBlaze](https://stackblaze.com). Both options run on **Kubernetes** for reliability and scalability.

<details>
<summary><strong>Standard Deployment</strong> — Single-instance Kubernetes setup for startups and moderate traffic</summary>

<br/>

```mermaid
flowchart LR
    U["Customers"] -->|HTTPS| LB["Edge Network\n+ SSL"]
    LB --> B["Webiny\nNode.js"]
    B --> DB[("PostgreSQL\nManaged DB")]
    B --> S3["Object Storage\nMedia + Assets"]

    style LB fill:#ff9800,stroke:#e65100,color:#fff
    style B fill:#0041ff,stroke:#002db3,color:#fff
    style DB fill:#4caf50,stroke:#2e7d32,color:#fff
    style S3 fill:#2196f3,stroke:#1565c0,color:#fff
```

**What you get:**
- Single Webiny instance on Kubernetes
- Managed PostgreSQL database
- Automatic SSL/TLS via StackBlaze edge network
- Object storage for media and assets
- Automated daily backups
- Zero-downtime deploys

**Best for:** Development, staging, and moderate-traffic production environments.

</details>

<details>
<summary><strong>High Availability Deployment</strong> — Multi-instance Kubernetes setup for business-critical production</summary>

<br/>

```mermaid
flowchart LR
    U["Customers"] -->|HTTPS| CDN["CDN\nStatic Assets"]
    CDN --> LB["Load Balancer\nAuto-scaling"]
    LB --> B1["Webiny #1"]
    LB --> B2["Webiny #2"]
    LB --> B3["Webiny #N"]
    B1 --> R[("Redis\nSessions + Cache")]
    B2 --> R
    B3 --> R
    B1 --> DBP[("PostgreSQL Primary\nRead + Write")]
    B2 --> DBP
    B3 --> DBR[("PostgreSQL Replica\nRead-only")]
    DBP -.->|Replication| DBR
    B1 --> S3["Object Storage\nMedia + Assets"]
    B2 --> S3
    B3 --> S3
    B1 --> Q["Queue Worker\nBackground Jobs"]
    Q --> R
    Q --> DBP

    style CDN fill:#607d8b,stroke:#37474f,color:#fff
    style LB fill:#ff9800,stroke:#e65100,color:#fff
    style B1 fill:#0041ff,stroke:#002db3,color:#fff
    style B2 fill:#0041ff,stroke:#002db3,color:#fff
    style B3 fill:#0041ff,stroke:#002db3,color:#fff
    style R fill:#f44336,stroke:#c62828,color:#fff
    style DBP fill:#4caf50,stroke:#2e7d32,color:#fff
    style DBR fill:#66bb6a,stroke:#388e3c,color:#fff
    style S3 fill:#2196f3,stroke:#1565c0,color:#fff
    style Q fill:#9c27b0,stroke:#6a1b9a,color:#fff
```

**What you get:**
- Auto-scaling Webiny pods on Kubernetes behind a load balancer
- Redis for shared sessions, cache, and queue management
- PostgreSQL primary + read replica for high throughput
- CDN for static assets (images, CSS, JS)
- Background queue workers for async processing
- Shared object storage across all instances
- Automated failover and self-healing
- Zero-downtime rolling deploys

**Best for:** Production workloads, high-traffic applications, business-critical deployments.

</details>

---

### Maintained by [StackBlaze](https://stackblaze.com)

Weekly automated checks for up-to-date dependencies, security scanning, and best practices.

---

## Security

### Required environment variables

Before running in any shared or production environment, set the following variables (copy `.env.example` to `.env`):

| Variable | Description |
|---|---|
| `POSTGRES_PASSWORD` | **Required.** PostgreSQL password — must be changed from the default. |
| `POSTGRES_USER` | PostgreSQL username (default: `webiny`). |
| `POSTGRES_DB` | PostgreSQL database name (default: `webiny`). |

> **Warning:** The default `docker-compose.yml` will refuse to start unless `POSTGRES_PASSWORD` is set in your environment or a `.env` file. Do not use the placeholder value from `.env.example` in production.

### Insecure defaults to change before production

- **Database password**: the `.env.example` placeholder (`change_me_before_running`) is not a valid secret — replace it with a strong, randomly generated password.
- **`NODE_ENV`**: the Docker image sets `NODE_ENV=production`. Do not override this to `development` in production deployments.

