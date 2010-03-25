module VirtualBox
  module FFI
    IPERFORMANCECOLLECTOR_IID_STR = "e22e1acb-ac4a-43bb-a31c-17321659b0c6"

    # Callbacks for IPerformanceCollector_vtbl
    callback :ipc_GetMetricNames, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ipc_GetMetrics, [:pointer, PRUint32, :pointer, PRUint32, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ipc_SetupMetrics, [:pointer, PRUint32, :pointer, PRUint32, :pointer, PRUint32, PRUint32, PRUint32, :pointer], NSRESULT_TYPE
    callback :ipc_EnableMetrics, [:pointer, PRUint32, :pointer, PRUint32, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ipc_DisableMetrics, [:pointer, PRUint32, :pointer, PRUint32, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ipc_QueryMetricsData, [:pointer, PRUint32, :pointer, PRUint32, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE

    class IPerformanceCollector < VTblParent
      parent_of :IPerformanceCollector_vtbl
    end

    class IPerformanceCollector_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl
        member :GetMetricNames, :ipc_GetMetricNames
        member :GetMetrics, :ipc_GetMetrics
        member :SetupMetrics, :ipc_SetupMetrics
        member :EnableMetrics, :ipc_EnableMetrics
        member :DisableMetrics, :ipc_DisableMetrics
        member :QueryMetricsData, :ipc_QueryMetricsData
      end
    end
  end
end