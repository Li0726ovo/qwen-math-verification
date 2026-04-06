#!/usr/bin/env python3
"""
测试脚本：验证优化后的代码语法正确性
"""
import sys
import ast
from pathlib import Path

def test_syntax(file_path):
    """测试Python文件语法"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            code = f.read()
        ast.parse(code)
        print(f"✅ {file_path.name}: 语法正确")
        return True
    except SyntaxError as e:
        print(f"❌ {file_path.name}: 语法错误 - {e}")
        return False
    except Exception as e:
        print(f"⚠️ {file_path.name}: 其他错误 - {e}")
        return False

def main():
    base_path = Path(__file__).parent
    
    # 测试核心文件
    files_to_test = [
        base_path / 'app.py',
        base_path / 'core' / 'api_client.py',
        base_path / 'gui' / 'main_window.py',
        base_path / 'gui' / 'styles.py',
        base_path / 'config.py'
    ]
    
    print("=" * 50)
    print("语法测试开始")
    print("=" * 50)
    
    results = []
    for file_path in files_to_test:
        if file_path.exists():
            results.append(test_syntax(file_path))
        else:
            print(f"⚠️ 文件不存在: {file_path}")
            results.append(False)
    
    print("=" * 50)
    passed = sum(results)
    total = len(results)
    print(f"测试结果: {passed}/{total} 通过")
    
    if passed == total:
        print("✅ 所有文件语法正确！")
        return 0
    else:
        print("❌ 部分文件存在语法错误")
        return 1

if __name__ == "__main__":
    sys.exit(main())