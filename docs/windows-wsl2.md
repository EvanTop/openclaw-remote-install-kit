# Windows 安装建议（强推 WSL2）

> 结论：Windows 原生环境变量、PATH、证书、构建依赖差异太多。
> 为了稳定与可复制，**推荐 100% 使用 WSL2 + Ubuntu**。

---

## 1. 安装/启用 WSL2（管理员 PowerShell）

```powershell
wsl --install
```

重启后，确认：

```powershell
wsl -l -v
```

如果没看到 Ubuntu，可以在 Microsoft Store 安装 Ubuntu（22.04/24.04 均可）。

---

## 2. 在 WSL2 里准备环境

打开 Ubuntu 终端：

```bash
sudo apt-get update -y
sudo apt-get install -y curl ca-certificates git
```

### 安装 Node.js（要求 >=22）
你可以用你熟悉的方法：
- fnm/nvm
- 或发行版包（注意版本可能偏旧）

（示例：用 fnm，速度快、版本管理方便）

```bash
curl -fsSL https://fnm.vercel.app/install | bash
source ~/.bashrc || true
fnm install 22
fnm use 22
node -v
```

---

## 3. 代理验收（公司/校园网络必做）

```bash
curl -I https://openclaw.ai
npm ping
```

不通就看：docs/proxy.md

---

## 4. 执行一键安装

```bash
curl -fsSL https://raw.githubusercontent.com/evantop/openclaw-remote-install-kit/main/scripts/openclaw-quick-install.sh | bash
```

---

## 5. 验收

```bash
openclaw doctor
openclaw status
openclaw health
openclaw dashboard
```
