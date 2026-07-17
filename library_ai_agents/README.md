# 🤖 Library AI Agents

This directory contains the AI agents used by the Smart Library Management System.

Built using the **Google Agent Development Kit (ADK)**, these agents enable users to interact with the Smart Library database using natural language. Rather than manually navigating APIs or writing queries, users can simply describe what information they need, and the appropriate agent retrieves or analyzes the data using the tools exposed by the ORMCP server.

Each agent has a specific responsibility, allowing the system to separate operational tasks from analytical workloads while sharing the same backend infrastructure.

> **Note:** The overall project architecture, backend services, and deployment instructions are documented in the main repository README. This directory focuses only on the AI agents.

---

# Directory Structure

| Directory | Purpose |
|-----------|---------|
| `smart_library_agent/` | AI assistant for day-to-day library operations such as retrieving books, members, staff, libraries, and transactions. |
| `library_analytics_agent/` | Read-only AI assistant for generating summaries, reports, statistics, and analytical insights about the library database. |

```
library_ai_agents/
│
├── smart_library_agent/
│   ├── agent.py
│   ├── __init__.py
│   ├── .env
│   └── .adk/
│
└── library_analytics_agent/
    ├── agent.py
    ├── __init__.py
    ├── .env
    └── .adk/
```

---

# Smart Library Agent

The **Smart Library Agent** is designed for operational interactions with the Smart Library Management System.

It can answer queries related to:

- Libraries
- Books
- Members
- Staff
- Library Transactions

### Example Queries

- Show all available books.
- List all registered members.
- Display library details.
- Show all transactions.
- Which books are currently issued?
- Find information about a specific member.

This agent uses the ORMCP tools to retrieve and manage information from the backend object model.

---

# Library Analytics Agent

The **Library Analytics Agent** focuses on reporting and data analysis.

Unlike the Smart Library Agent, it is configured with **read-only instructions** and is intended for generating insights rather than performing operational tasks.

### Example Queries

- Generate a summary of the library database.
- Count the total number of books.
- Count registered members.
- Show transaction statistics.
- Identify frequently issued books.
- Produce a library activity report.

---

# Agent Files

Each agent directory contains the following files.

| File | Description |
|------|-------------|
| `agent.py` | Defines the ADK agent, its model, instructions, and ORMCP tool configuration. |
| `__init__.py` | Marks the directory as a Python package. |
| `.env` | Stores environment variables required by the agent (for example, API keys and configuration values). |
| `.adk/` | Generated ADK runtime configuration and metadata. |

---

# Running an Agent

From the `library_ai_agents` directory, run either agent using the Google ADK CLI.

For the Smart Library Agent:

```bash
adk run smart_library_agent
```

or launch the web interface:

```bash
adk web
```

The same approach can be used for the Library Analytics Agent.

> Ensure that the required backend services (ORMCP server and Gilhari microservice) are already running before starting the agents.

---

# Choosing the Right Agent

| Smart Library Agent | Library Analytics Agent |
|---------------------|-------------------------|
| Operational tasks | Reporting and analytics |
| Retrieves library information | Generates summaries and insights |
| Handles day-to-day queries | Read-only analytical queries |
| General-purpose assistant | Analytics-focused assistant |

---

# Purpose

These agents demonstrate how specialized AI assistants can be developed using Google ADK to interact with the same backend while serving different user needs. By separating operational and analytical responsibilities, the project illustrates a modular approach to AI agent development that is easier to extend, maintain, and customize for future applications.