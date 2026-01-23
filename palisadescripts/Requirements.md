# Script Requirements

This document defines the runtime and system requirements for all scripts discussed in this topic, intended for use within the PalisadeOS development workflow.

## Supported Environments

The scripts are designed to run on:

* Linux distributions (Debian, Ubuntu, Arch, Fedora)
* Android via Termux
* WSL (Windows Subsystem for Linux)
* Minimal build hosts used for OS / firmware development

POSIX-compliant shells are assumed.

---

## Mandatory Tools

The following tools are strictly required and must be available in `PATH`:

* **bash**

  * Minimum version: 4.x
  * Used for control flow, strict error handling, and portability

* **curl**

  * Used to fetch repository metadata and raw file contents from GitHub
  * HTTPS support required

* **jq**

  * Used to parse JSON responses from the GitHub REST API
  * Required for recursive tree traversal and file filtering

* **unzip**

  * Used exclusively for extracting `.zip` archives
  * Must support overwrite mode (`-o`)

---

## Optional (But Recommended)

These tools are not required but improve robustness:

* **coreutils**

  * Provides `dirname`, `basename`, `mkdir`, `rm`

* **ca-certificates**

  * Ensures TLS validation when accessing GitHub

---

## Network Requirements

* Outbound HTTPS access to:

  * `api.github.com`
  * `raw.githubusercontent.com`

* No authentication required (public repository)

* GitHub API rate limits apply if scripts are executed frequently

---

## Filesystem Requirements

* Write access to:

  * `/tmp` (temporary download and extraction)
  * `/palisade/os/framework` (final extraction target)

* Sufficient disk space to temporarily hold ZIP archives during extraction

---

## Permissions

* Scripts must be executable:

```sh
chmod +x *.sh
```

* Root privileges are **not** required unless `/palisade` is owned by root

---

## Explicit Non-Requirements

The scripts intentionally do **not** require:

* `git`
* Android SDK / NDK
* Gradle
* Python, Node.js, or Java
* Build systems (Make, Soong, Bazel)

---

## Design Constraints

* No repository cloning
* No modification of source ZIP archives
* Deterministic behavior suitable for OS build pipelines
* Compatible with firmware-level staging environments

---

## Intended Usage Context

These requirements align with PalisadeOS goals:

* Minimal, inspectable tooling
* Reproducible framework resource ingestion
* Safe execution on constrained or early-stage systems

End of document.

