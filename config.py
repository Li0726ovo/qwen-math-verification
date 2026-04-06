from typing import TypedDict, Literal

class APIConfig(TypedDict):
    base_url: str
    model: str | None
    api_key: str | None
    enabled: bool

API_CONFIG: dict[Literal["ollama", "siliconflow", "deepseek"], APIConfig] = {
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
    },
    "deepseek": {
        "base_url": "https://api.deepseek.com/v1",
        "model": "deepseek-chat",
        "api_key": "",
        "enabled": True
    }
}