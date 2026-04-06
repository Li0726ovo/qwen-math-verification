import cProfile
import pstats
from app import main

if __name__ == "__main__":
    # 使用cProfile运行应用
    profiler = cProfile.Profile()
    profiler.enable()
    
    try:
        # 运行应用（注意：这会启动GUI，需要手动关闭）
        main()
    except SystemExit:
        # 捕获sys.exit()调用
        pass
    finally:
        profiler.disable()
        
        # 分析结果
        stats = pstats.Stats(profiler)
        stats.sort_stats('cumulative')  # 按累积时间排序
        
        # 打印前20个最耗时的函数
        print("\n===== 性能分析结果 =====")
        print("前20个最耗时的函数：")
        stats.print_stats(20)
        
        # 保存结果到文件
        stats.dump_stats('profile_results.prof')
        print("\n性能分析结果已保存到 profile_results.prof")
