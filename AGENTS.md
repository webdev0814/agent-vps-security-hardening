# Agent Briefing: agent-vps-security-hardening

## 1. Repository Overview & Purpose
- **Repository**: `webdev0814/agent-vps-security-hardening`
- **Visibility**: `Public`
- **Default Branch**: `main`
- **Last Updated / Pushed**: 2026-09-08
- **Description**: VPS security hardening protocols tailored for independent AI agent hosts and deployments.
- **Context from README**: A harness-agnostic security hardening procedure for running AI agents, automation harnesses, chatbots, browser workers, and orchestration services on public VPS hosts. It is intentionally not tied to OpenClaw, Hermes, LangChain, AutoGen, CrewAI, custom Python bots, Node services, or any specific age...
- **Topics/Tags**: devops, hardening, security, vps-security

---

## 2. Tech Stack & Architecture
- **Primary Language / Ecosystem**: Shell, Shell / Bash
- **Key Directories**: `docs/`, `scripts/`
- **Notable Top-Level Files**: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `LICENSE`, `README.md`

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
- `[99fface]` (2026-09-08) docs: update agent briefing with multi-computer handoff protocol
- `[4da5ba3]` (2026-09-08) docs: update agent briefing with multi-computer handoff protocol
- `[30566a2]` (2026-09-08) docs: update agent briefing with multi-computer handoff protocol
- `[b264f71]` (2026-09-08) docs: update agent briefing with multi-computer handoff protocol
- `[a8fc02f]` (2026-09-08) docs: update agent briefing with multi-computer handoff protocol
- `[3aaa3d7]` (2026-09-08) docs: update agent briefing with multi-computer handoff protocol
- `[bda3232]` (2026-09-08) docs: update agent briefing with multi-computer handoff protocol
- `[bf7f284]` (2026-09-08) docs: update agent briefing with multi-computer handoff protocol
- `[a9567cc]` (2026-09-08) docs: update agent briefing with multi-computer handoff protocol
- `[f37f532]` (2026-09-08) docs: update agent briefing (AGENTS.md, GEMINI.md, CLAUDE.md)

---

## 5. Current State & Immediate Next Steps
- **Current State**: Project is active under branch `main`.
- **When picking up this repo**:
  1. Inspect the top-level files and recent commits to understand the active feature or bugfix context.
  2. Verify all required credentials and environment variables before running integration scripts.
  3. Ensure all tests and linting pass after making modifications.
  4. Follow the repository conventions and preserve existing architecture patterns.

---

## 6. Multi-Computer Handoff & Git Sync Protocol
- **On Session Start**: Always run `git pull` when opening this repository on any computer to synchronize the latest changes.
- **On Task Completion**: Before ending any agent session, the agent **MUST**:
  1. Update Section 5 (Current State & Next Steps) in this `AGENTS.md` file.
  2. Stage all modifications (`git add .`).
  3. Commit with a concise conventional message (`git commit -m "feat/fix: ..."`).
  4. Push directly to GitHub (`git push`).
- **Secret Hygiene**: NEVER commit plain-text API keys, tokens, or credentials into repository files.
