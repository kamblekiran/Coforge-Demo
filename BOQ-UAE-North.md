# BOQ - Production Environment (UAE North)

This BOQ provides estimated monthly ranges in USD for the required assignment resources.

## Assumptions

- Region: UAE North
- Environment: 1 production environment
- AKS worker nodes: 3 to 6 nodes
- App Service: Linux, production tier, 2 to 5 instances
- Monitoring: Azure Monitor + Log Analytics enabled
- Security: Defender baseline enabled

## Estimated Monthly Cost Range

| Resource | SKU/Tier | Qty (Typical) | Monthly Cost Range (USD) | HA/Security Notes |
|---|---|---:|---:|---|
| AKS worker compute + OS disks | D4s v5 class | 3-6 nodes | 700-2000 | Multi-node, zone-aware node pool |
| AKS LB, Public IP, data transfer | Standard | 1 set | 80-400 | Standard LB with secured ingress |
| Azure Container Registry | Premium | 1 | 150-300 | Production tier for enterprise controls |
| Azure Key Vault | Standard | 1 | 10-60 | Purge protection + soft delete |
| Azure App Service Plan | P1v3/P2v3 | 2-5 instances | 250-900 | Autoscale and Always On enabled |
| Azure Monitor + Log Analytics | PerGB2018 | Shared | 200-1200 | Centralized diagnostics and retention |
| Azure Monitor Alerts | Standard | Shared | 20-120 | Infra and app alerting |
| Defender for Cloud | Standard plans | Shared | 150-700 | Container and cloud posture protection |
| Backup/Recovery services | Standard | Shared | 50-300 | Backup for app/config and data paths |

## Estimated Total

- Lean production baseline: 1,610 to 2,800 USD/month
- Typical production baseline: 2,800 to 5,000 USD/month
- Higher traffic/telemetry profile: 5,000 to 8,000+ USD/month

## Notes

- Actual billing depends on traffic, data retention, egress, and selected SKUs.
- Validate final values in Azure Pricing Calculator before submission.
