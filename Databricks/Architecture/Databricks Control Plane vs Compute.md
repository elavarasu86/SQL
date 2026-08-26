Databricks Control Plane vs Compute Plane

A clear, engineering‑focused explanation with a simple flow diagram.

🧩 Overview

Databricks separates its architecture into two major layers:

Control Plane — Managed by Databricks; handles orchestration, security, governance, and workspace management.

Compute Plane — Runs in your cloud account (or Databricks serverless); executes Spark jobs, SQL queries, ML workloads, and interacts with your data.

This separation ensures security, scalability, and clear responsibility boundaries.

🏛️ Control Plane

The Control Plane is fully managed by Databricks and contains:

Workspace UI & notebooks

Job scheduler & orchestration services

Cluster lifecycle management

Authentication & identity (SSO, SCIM)

Unity Catalog governance

Logging, monitoring, audit services

Billing & usage tracking

Key characteristics:

Does not access your raw data

Stores metadata only

Ensures governance and platform consistency

Routes requests to compute resources

⚙️ Compute Plane

The Compute Plane is where your actual workloads run:

Spark clusters (classic or serverless)

SQL warehouses

ML runtimes

Data ingestion & ETL pipelines

Streaming jobs (Event Hub, Kafka, Kinesis)

Key characteristics:

Runs inside your cloud account (Azure/AWS/GCP) unless serverless

Has access to your data lake, warehouse, and storage

Executes transformations, queries, and ML workloads

Scales elastically based on job needs

🔄 Flow Diagram (Markdown)

flowchart LR
    A[User / Notebook / Job] --> B[Control Plane<br/>UI, Scheduler, Auth, UC]
    B --> C[Compute Plane<br/>Spark Clusters / SQL Warehouses]
    C --> D[Cloud Storage<br/>ADLS / S3 / GCS]

    B --> E[Governance<br/>Unity Catalog / Policies]
    E --> C

    C --> F[Results Returned]
    F --> A

🧠 Summary

Control Plane = brains of the platform (orchestration, governance, security).

Compute Plane = muscle of the platform (actual data processing).

They work together to provide a secure, scalable, cloud‑native data engineering environment.