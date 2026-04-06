# Lean4 代码生成工具

这个项目提供了一个图形界面工具，帮助用户将自然语言描述的数学命题转换为Lean4代码，并提供代码验证功能，支持本地Ollama模型和硅基流动API两种生成方式。

## 功能特点

1. **自然语言到Lean4代码转换**：
   - 将数学命题转换为符合Lean4语法的代码
   - 自动添加必要的Mathlib导入
   - 生成完整的证明结构

2. **多API支持**：
   - Ollama本地模型（无需API密钥）
   - 硅基流动在线API（需API密钥）

3. **代码验证功能**：
   - 自动检测和修正Lean4代码错误
   - 支持多次迭代验证（最多3次）
   - 显示修正后的完整代码

4. **历史管理**：
   - 保存最多5个API配置历史记录
   - 快速加载之前的配置组合

5. **用户友好界面**：
   - 深色主题设计
   - 清晰的进度指示
   - 响应式布局

## 安装指南

### 系统要求
- Python 3.10+
- Ollama服务（如果使用本地模型）

### 安装依赖
```bash
# 安装依赖
pip install -r requirements.txt
```

### 配置Ollama（可选）
如果使用本地模型：
```bash
# 安装Ollama
curl -fsSL https://ollama.com/install.sh | sh

# 下载模型
ollama pull qwen:7b（可使用其他模型）
```

## 使用说明

### 打开图形界面

```bash
python app.py
```

1. 输入数学命题（例如："证明任意两个偶数的和仍然是偶数"）
2. 选择API来源（Ollama或硅基流动）
3. 点击"生成代码"按钮
4. 查看生成的Lean4代码
5. 使用"验证代码"功能可以检查并修正代码


## 配置文件

配置文件位于`config.py`：  

```python
API_CONFIG = {
    "ollama": {
        "base_url": "http://localhost:11434",
        "model": None,
        "api_key": None,
        "enabled": True
    },
    "siliconflow": {
        "base_url": "https://api.siliconflow.cn/v1",
        "model": "Qwen/Qwen3-Coder-480B-A35B-Instruct",
        "api_key": "",
        "enabled": True
    }
}
```
如果想要使用其他硅流模型，请在`api_history.json`中编辑  
如果你是运行的app.py，那么`api_history.json`位于gui文件夹下  
如果你运行的是exe文件，那么`api_history.json`位于C:\Users\ADOFAI\AppData\Local\MathAI\Lean4Generator目录下
## 注意事项

1. **API密钥安全**：
   - 硅基流动API密钥存储在本地历史记录中
   - 避免在公共计算机上保存敏感API密钥

2. **性能考虑**：
   - Ollama本地生成可能需要很长时间
   - 复杂命题可能需要多次验证迭代

3. **模型要求**：
   - 确保本地模型支持代码生成任务
   - 硅基流动模型需要支持文本模态

## 主要项目结构

```
qwen3_lean_prover/
├── gui/                    # 图形界面模块
│   ├── main_window.py       # 主窗口实现
│   ├── history_manager.py   # 配置历史管理
│   └── styles.py            # 界面样式
├── core/                   # 核心功能
│   ├── api_client.py        # API客户端
│   └── iterative_validator.py # 迭代验证器
├── config.py               # 配置文件
├── app.py                  # 应用入口
└── requirements.txt        # 依赖列表
```

### 提示
这个程序中默认有一个硅流的模型和api秘钥，同时也避免第一次加载没有api_history.json这个文件，这个秘钥仅供内部测试使用，你是用的软件中这个秘钥是无效的，你需要使用自己的api秘钥，再次强调！！！


代码生成或者验证时程序未响应属于正常现象  
另外如果你的模型量化参数太小，可能导致程序获取返回数据异常，从而无法正常输出结果，所以为了保证使用体验，尽量使用硅流api进行转译