class Task
    attr_accessor :name
    def initialize(name)
        @name = name
    end

    def get_time_required
        0.0
    end
end

class CompositeTask < Task
    attr_accessor :sub_tasks
    def initialize(name)
        super(name)
        @sub_tasks = []
    end

    def <<(task)
      @sub_tasks << task
      p task.name.to_s + ' was added'
    end

    def delete(task)
        @sub_tasks.delete(task)
    end

    def get_time_required
        time = 0.0
        @sub_tasks.each {|task| time += task.get_time_required}
        time
    end
end

class InstallLinux < Task
    def initialize
        super('InstallLinux')
    end

    def get_time_required
        60.0
    end
end

class InstallRuby < Task
    def initialize
        super('InstallRuby')
    end

    def get_time_required
        2.0
    end
end

class InstallSvn < Task
    def initialize
        super('InstallSvn')
    end

    def get_time_required
        1.0
    end
end

class DownloadClone < Task
    def initialize
        super('DownloadClone')
    end

    def get_time_required
        20.0
    end
end

class UpdateClone < Task
    def initialize
        super('UpdateClone')
    end

    def get_time_required
        5.0
    end
end

class MakeClone < CompositeTask
    def initialize
        super('MakeClone')
        self << DownloadClone.new
        self << UpdateClone.new
    end
end


class MakeInstalation < CompositeTask
    def initialize
        super('FullInstall')
        self << InstallLinux.new
        self << InstallRuby.new
        self << InstallSvn.new
    end
end

class PrepareProduct < CompositeTask
     def initialize
        super('PrepareProduct')
        self << MakeInstalation.new
        self << MakeClone.new
     end
end

product = PrepareProduct.new
p product.get_time_required

