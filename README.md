
# OpenClaw macOS 一键安装（从零到可用）

> 适用：**macOS 为主**（Linux 同样可用）。  
> Windows 用户强烈建议走 **WSL2**：见 `docs/windows-wsl2.md`。

你将获得：
- 一条命令完成安装 + 引导（调用官方安装器，最稳）
- 可复制粘贴的验收命令（`doctor/status/health`）
- 网络/代理不通时的先验收方案（避免反复失败）
- 远端常驻 Gateway + 本地远程使用（可选）：`docs/remote-gateway.md`

---

## 0) 安装前 30 秒自检（强烈建议先做）

### 0.1 Node 版本（硬要求）
OpenClaw 要求 **Node.js ≥ 22**：

```bash
node -v
```

如果版本 < 22，请先升级 Node（推荐用 fnm/nvm 管理版本）。

### 0.2 网络验收（公司/校园/国内网络必做）
先确认能访问官方安装入口和 npm：

```bash
curl -I https://openclaw.ai
npm ping
```

通过标准：
- `curl` 返回 200/301/302 等（不要超时）
- `npm ping` 返回 `pong`

不通过请先处理：`docs/proxy.md`

---

## 1) 一键安装（macOS / Linux）

> 说明：这个脚本会做 **Preflight → 调用官方安装器 → `openclaw onboard --install-daemon` → 基础健康检查**。  
> 如果你的网络/代理没搞定，会卡在下载/安装阶段，所以请优先完成第 0 步的网络验收。

```bash
curl -fsSL https://raw.githubusercontent.com/EvanTop/openclaw-remote-install-kit/main/scripts/openclaw-quick-install.sh | bash
```

---

## 2) 安装后验收（必须做）

复制粘贴运行：

```bash
openclaw doctor
openclaw status
openclaw health
```

打开控制面板：

```bash
openclaw dashboard
```

---

## 3) macOS 权限说明（想用“控制/录屏/语音”等能力才需要）

如果你只用 WebChat/消息渠道和它对话，通常不需要额外权限。

如果你希望 OpenClaw 在 macOS 上具备更强的设备能力（如录屏、控制、麦克风、语音唤醒等），请按系统提示在：

**系统设置 → 隐私与安全性** 中为相关组件授予权限。常见可能涉及：
- 辅助功能（Accessibility）
- 自动化（Automation）
- 屏幕录制（Screen Recording）
- 麦克风（Microphone）
- 语音识别（Speech Recognition）
- 通知（Notifications）

> 提示：权限经常是“能装好但用不了”的根因；建议第一次就把提示出现的权限都按引导授完。

---

## 4) 常见问题（快速修）

### 4.1 安装后提示 `openclaw: command not found`
通常是全局 npm 的 bin 目录不在 PATH。

当前终端临时修复：

```bash
export PATH="$(npm prefix -g)/bin:$PATH"
openclaw --version
```

如果好了，把这行写入你的 `~/.zshrc` 或 `~/.bashrc`，然后重开终端。

更多见：`docs/faq.md#openclaw-not-found`

### 4.2 Node 版本太低（< 22）
见：`docs/faq.md#node-too-old`

### 4.3 网络/代理导致安装失败
先不要反复重装，先跑网络验收：

```bash
curl -I https://openclaw.ai
npm ping
```

不通过见：`docs/proxy.md`

### 4.4 远程连接/远端常驻 Gateway
见：`docs/remote-gateway.md`

---

## 5) 目录说明（你仓库里有什么）

- `scripts/openclaw-quick-install.sh`：macOS/Linux 一键安装脚本
- `docs/proxy.md`：代理与网络排查（先验收再安装）
- `docs/windows-wsl2.md`：Windows 走 WSL2 的推荐安装流程
- `docs/remote-gateway.md`：远端常驻 Gateway + 远程访问（SSH/Tailscale 思路）
- `docs/faq.md`：常见问题

---

## 6) 官方参考（权威）

- 安装：https://docs.openclaw.ai/zh-CN/install  
- 远程访问：https://docs.openclaw.ai/gateway/remote  
- 项目主页：https://github.com/openclaw/openclaw  

--- 
