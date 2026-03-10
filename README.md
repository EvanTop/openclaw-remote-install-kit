# OpenClaw 一键安装与远程代装（从零到可用）

> 适用人群：第一次接触 OpenClaw、不会装环境、网络/代理复杂、或需要把 OpenClaw 跑在远端服务器并远程使用。

**你将得到什么**
- 一条命令完成安装（macOS/Linux；Windows 推荐 WSL2）
- 可验收的检查步骤（`doctor/status/health`）
- 代理/公司网络下的“先验收再安装”流程
- 远端常驻 Gateway（Linux VPS/家用服务器）+ 本地远程使用（SSH 隧道 / Tailscale）的标准做法

**官方参考（强烈建议收藏）**
- 安装：https://docs.openclaw.ai/zh-CN/install
- 远程访问：https://docs.openclaw.ai/gateway/remote
- GitHub：https://github.com/openclaw/openclaw

---

## 0. 安装前必须知道的 3 件事

### 0.1 系统支持
- macOS / Linux：原生支持
- Windows：**官方建议通过 WSL2（强烈推荐）**

### 0.2 硬性环境要求
- **Node.js ≥ 22**（硬要求）

### 0.3 最常见失败原因
1) 访问不了 `openclaw.ai` / npm / GitHub（网络/代理问题）
2) Node 版本不够（< 22）
3) 安装后 `openclaw` 不在 PATH（全局 npm bin 未加入 PATH）

---

## 1. 代理/网络：先做“验收”，通过了再安装（强烈建议）

只要这一步通过，后面成功率会大幅提升。

### 1.1 macOS / Linux：网络验收

```bash
curl -I https://openclaw.ai
npm ping
```

### 1.2 Windows PowerShell：网络验收

```powershell
irm https://openclaw.ai -Method Head
npm ping
```

**判定标准**
- `curl/irm` 返回 200/301/302 等正常状态码（不是超时）
- `npm ping` 返回 `pong`

如果失败：请先按《代理与网络排查》处理：
- docs/proxy.md

---

## 2. 一键安装（推荐路径）

建议全程复制粘贴；不要跳步。

### 2.1 macOS / Linux 一键安装

```bash
curl -fsSL https://raw.githubusercontent.com/evantop/openclaw-remote-install-kit/main/scripts/openclaw-quick-install.sh | bash
```

脚本会做：
- 环境预检（Node 版本、连通性提示）
- 调用官方安装器
- 运行 `openclaw onboard --install-daemon`
- 执行 `doctor/status/health`

### 2.2 Windows（推荐 WSL2）

Windows 用户请先阅读：
- docs/windows-wsl2.md

安装完成后，在 WSL2 的 Ubuntu 终端里执行与 Linux 同样的一键命令即可。

---

## 3. 安装后验收（你一定要做）

### 3.1 基础验收

```bash
node -v
openclaw --version
openclaw doctor
openclaw status
openclaw health
```

### 3.2 打开控制面板

```bash
openclaw dashboard
```

---

## 4. 两种常用部署模式（选一种就够）

### 模式 A：本机部署（最简单）
- Gateway 和你电脑在同一台机器
- 适合：个人使用、电脑经常开机

### 模式 B：远端常驻（更稳定，适合长期服务）
- Gateway 跑在 Linux 服务器/家用主机
- 你的电脑/手机作为远程控制端
- 访问方式：
  - 优先：Tailscale（推荐）
  - 兜底：SSH 隧道转发 18789

远端模式详细：docs/remote-gateway.md

---

## 5. 常见问题（快速入口）

- 安装后找不到 `openclaw`：docs/faq.md#openclaw-not-found
- Node 版本不够：docs/faq.md#node-too-old
- 网络/代理：docs/proxy.md
- 远程访问：docs/remote-gateway.md
