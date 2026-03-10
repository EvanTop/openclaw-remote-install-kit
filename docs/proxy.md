# 代理与网络排查（先验收再安装）

> 这份文档的目标：让你在公司/校园/海外/代理环境下，先把网络打通，再安装 OpenClaw。

---

## 1. 你需要能访问哪些站点？

最小集合：
- `https://openclaw.ai`（官方安装器入口）
- npm registry（用于 `npm install -g openclaw@latest`）

可选：
- `https://github.com`（查看仓库、脚本内容、文档）

---

## 2. 一步到位的“网络验收”

### 2.1 macOS / Linux

```bash
curl -I https://openclaw.ai
npm ping
```

### 2.2 Windows PowerShell

```powershell
irm https://openclaw.ai -Method Head
npm ping
```

通过标准：
- `curl/irm` 不超时；返回 200/301/302 等
- `npm ping` 返回 `pong`

---

## 3. 如果验收失败：按症状处理（决策树）

### 症状 A：`curl`/`irm` 超时或 DNS 失败
优先检查：
1) 你是否处在公司/校园内网，需要代理或白名单
2) 你是否开着代理，但终端没有走代理

**快速处理（只对当前终端生效）**：设置代理环境变量。

#### macOS / Linux（临时）

```bash
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"
```

然后重新验收：

```bash
curl -I https://openclaw.ai
```

#### Windows PowerShell（临时）

```powershell
$env:http_proxy="http://127.0.0.1:7890"
$env:https_proxy="http://127.0.0.1:7890"
irm https://openclaw.ai -Method Head
```

> 端口 `7890` 只是示例，请替换为你的代理软件实际端口。

---

### 症状 B：`npm ping` 失败
可能原因：
- npm registry 被墙/被内网策略限制
- 终端没有走代理

处理顺序：
1) 确认终端代理环境变量已设置（见上文）
2) 设置 npm 代理（不推荐长期；建议只在需要时用）

```bash
npm config set proxy http://127.0.0.1:7890
npm config set https-proxy http://127.0.0.1:7890
npm ping
```

恢复（取消配置）：

```bash
npm config delete proxy
npm config delete https-proxy
```

---

### 症状 C：能访问网页，但 `curl` 访问不了
原因：浏览器走系统代理，但终端没走。

解决：按上文设置 `http_proxy/https_proxy`，或让你的终端/系统统一代理。

---

## 4. 安全提醒
- 不要把 API Key 写进公开仓库
- 不要把代理账号密码发给任何人
- 如果需要远程协助，请使用临时会话/临时授权

---

## 5. 回到安装流程
网络验收通过后回到：
- README 的“一键安装”步骤
