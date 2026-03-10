# 远端常驻 Gateway（推荐给长期稳定使用）

> 核心思路：让 OpenClaw Gateway 常驻在一台稳定在线的机器（Linux VPS/家用服务器/办公主机），
> 客户电脑/你的电脑只做“远程控制端”。

官方远程访问说明（建议先读一遍）：
- https://docs.openclaw.ai/gateway/remote

---

## 1. 角色说明（别装错位置）

- **Gateway Host**：OpenClaw“住”的地方（持久运行、保存状态/渠道/凭证）
- **Operator**：你/客户用于操作的电脑（CLI 或 macOS app）
- **Node**：iOS/Android/macOS 的设备节点（相机/录屏/本地动作）

---

## 2. 在 Linux 服务器上安装（Gateway Host）

1) 网络验收

```bash
curl -I https://openclaw.ai
npm ping
```

2) 安装（使用本仓库一键脚本也可以）

```bash
curl -fsSL https://raw.githubusercontent.com/evantop/openclaw-remote-install-kit/main/scripts/openclaw-quick-install.sh | bash
```

3) 验收

```bash
openclaw doctor
openclaw status
openclaw health
```

---

## 3. 远程访问方式（优先级）

### 方案 A：Tailscale（推荐）
- 优点：安全、稳定、对网络要求低
- 建议：Gateway 保持 loopback bind，不直接公网暴露

（你的 Tailscale 具体设置因账号/网络而异，这里不强制写死命令；你可以在交付时由服务方协助。）

### 方案 B：SSH 隧道（官方兜底通用法）

在你的本机（Operator）执行：

```bash
ssh -N -L 18789:127.0.0.1:18789 user@server
```

然后你的本机将把远端 Gateway 映射为本地：
- `ws://127.0.0.1:18789`

你可以执行：

```bash
openclaw health
openclaw status
```

> 注意：如果你改过 Gateway 端口，请同步修改 `18789`。

---

## 4. 安全建议（强烈建议照做）

- 默认保持 Gateway 绑定 loopback
- 远程访问走 SSH/Tailscale
- 如果必须非 loopback 暴露：
  - 必须启用 token/password
  - 只在可信网络内使用

详细安全规则请参考官方：
- https://docs.openclaw.ai/gateway/remote

