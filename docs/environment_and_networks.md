# Separation and roles of dev / staging / production<br>

## 1) Development (Dev) Environment

   **Purpose**<br>
    - Used by developers for active coding, debugging, and experimentation.<br>
    - Frequent deployments for rapid development.<br>
    
  **Access control**<br>
    - Developers<br>
    - QA engineers<br>
    - DevOps engineers/SREs<br>
    
  **Role of testing**<br>
    - Unit tests, component tests, and early integration smoke tests.<br>

## 2) Staging

  **Purpose**<br>
    - Final verification by PMs and other stakeholders before pushing to the production.<br>
    - Pre-sale trials.<br>
    - To replicate production bugs.<br>
    - User Acceptance Testing (UAT).<br>
  
  **Access control**<br>
    - Developers(partial)<br>
    - QA engineers<br>
    - DevOps engineers/SREs<br>
    - Release managers
    - Customer success(support) team
    - Sales team
    - Customers/users(pre-sale trial)
    
  **Role of testing**<br>
    - Integration, performance, security, and user acceptance testing (UAT).

## 3) Production

  **Purpose**<br>
    - Serves real users and business-critical workloads.
    
  **Access control**<br>
    - Developers(logs and metrics)<br>
    - DevOps engineers/SREs(partial)<br>
    - Customer success(support) team<br>
    - Sales team<br>
    - Customers/users<br>
    
  **Role of testing**<br>
    - Relevant deployment strategies to ensure reliability.<br>
    - Post-deployment smoke test.<br>

## What should be kept the same vs. what should differ (DEV, STAGE, and PROD)
  **Same**<br>
    - Core application code<br>
    - Application and infrastructure architecture<br>
    - Os, runtime, third party/open source software version, dependencies and libraries<br>
    - Database schema<br>
    - Security controls and monitoring tools<br>
    - Deployment method<br>
    
  **Different**<br>
    - Log levels, feature flags, API keys/secrets, and environment variables<br>
    - Infrastructure and databases<br>
    - Resource(physical server/VM) capacity<br>
    - Monitoring(frequency) and alerting<br>
    - Security actions<br>
    - Data retention periods.<br>

# Positioning of testnet / mainnet

## Value
  **Testnet**<br>
  - Uses fake or valueless tokens.<br>
  - For experiment without financial risk.<br>

  **Mainnet**<br>
  - Uses real cryptocurrency, NFT, and tokens with actual monetary value.<br>
  - Transactions involve real economic stakes.<br>

## Operational Risk
  **Testnet**<br>
  - Failures have no real-world consequences.<br>
  - A safe space to make mistakes and fix bugs.<br>
  - Used to validate architecture and deployment pipelines before mainnet launch.<br>
  
  **Mainnet**<br>
  - Bugs, misconfigurations, or exploits can lead to irreversible financial loss, reputational damage, or regulatory consequences.<br>
  - Uptime and performance directly impact users and stakeholders.<br>
  - Strict security policies, monitoring, and critical incident response.<br>

## Irreversibility
  **Testnet**<br>
  - Transactions are technically irreversible on-chain, but since the network has no real value it has no real-world consequences.<br>
  
  **Mainnet**<br>
  - All transactions are permanent and irreversible once confirmed.<br>
  - No central authority can "undo" a transaction-even if it results from a bug or hack.<br>
    
  
  

