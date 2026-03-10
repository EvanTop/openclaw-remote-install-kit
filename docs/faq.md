# FAQ（常见问题）

## openclaw-not-found
### 症状：安装后提示 `openclaw: command not found`

原因：全局 npm 的 bin 目录不在 PATH。

macOS/Linux 快速修复（当前终端）：

```bash
export PATH="$(npm prefix -g)/bin:$PATH"
openclaw --version
```

永久修复：把上面那行加到 `~/.zshrc` 或 `~/.bashrc`，然后重开终端。

官方参考：安装文档的 PATH 小节
- https://docs.openclaw.ai/zh-CN/install

---

## node-too-old
### 症状：Node 版本 < 22

OpenClaw 要求 Node >= 22。

解决：升级 Node（推荐用 fnm/nvm 管理版本）。

---

## install-fails-network
### 症状：安装器下载失败、npm 超时

先不要反复安装，先做网络验收：

```bash
curl -I https://openclaw.ai
npm ping
```

不通请看：docs/proxy.md

---

## remote-cant-connect
### 症状：远程连接不上 Gateway

按顺序检查：
1) 远端 `openclaw status` 是否正常
2) SSH 隧道是否建立、端口是否一致（默认 18789）
3) 网络/防火墙是否阻断 SSH

官方参考：
- https://docs.openclaw.ai/gateway/remote
