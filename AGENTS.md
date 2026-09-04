# Agent Briefing: agent-vps-security-hardening

## 1. Repository Overview & Purpose
- **Repository Name**: `agent-vps-security-hardening`
- **Visibility**: `Public`
- **Default Branch**: `main`
- **Last Updated / Pushed**: 2026-05-15
- **Description**: VPS security hardening protocols tailored for independent AI agent hosts and deployments.
- **Context from README**: A harness-agnostic security hardening procedure for running AI agents, automation harnesses, chatbots, browser workers, and orchestration services on public VPS hosts. It is intentionally not tied to OpenClaw, Hermes, LangChain, AutoGen, CrewAI, custom Python bots, Node services, or any specific age...
- **Topics/Tags**: devops, hardening, security, vps-security

---

## 2. Tech Stack & Architecture
- **Primary Language / Ecosystem**: Shell, Shell / Bash
- **Key Directories**: `docs/`, `scripts/`
- **Notable Top-Level Files**: `LICENSE`, `README.md`

---

## 3. Setup & Execution Commands
### Environment Setup & Installation
```bash
# Review repository files and install dependencies corresponding to the language/runtime.
```

### Running / Starting
```bash
# Check main entry point scripts or config files.
```

### Testing / Verification
```bash
# Run relevant unit/integration tests (e.g. pytest or npm test)
```

---

## 4. Recent Commit Activity (Where We Left Off)
The most recent commits show the latest development trajectory:
- `[f5739c3]` (2026-05-15) Add harness-agnostic VPS hardening procedure

---

## 5. Current State & Immediate Next Steps
- **Current State**: Project is active under branch `main`.
- **When picking up this repo**:
  1. Inspect the top-level files and recent commits to understand the active feature or bugfix context.
  2. Verify all required credentials and environment variables before running integration scripts.
  3. Ensure all tests and linting pass after making modifications.
  4. Follow the repository conventions and preserve existing architecture patterns.

---

## 6. Agent Working Guidelines & Gotchas
- **Cross-Platform Compatibility**: Code may run across Windows, macOS, or Linux agent environments. Ensure path manipulations use OS-agnostic methods (e.g. `pathlib.Path` or `path.join`).
- **Secret Hygiene**: NEVER commit plain-text API keys, tokens, or credentials into repository files.
- **Git Commit Etiquette**: Use concise, conventional commit messages (e.g., `feat:`, `fix:`, `docs:`, `refactor:`).
- **Tooling Compatibility**: This briefing is kept aligned for Antigravity (`GEMINI.md`), Claude Code / Codex (`CLAUDE.md`), and general autonomous agents (`AGENTS.md`).
