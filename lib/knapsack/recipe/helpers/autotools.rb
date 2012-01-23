module Knapsack
  class Recipe
    module Helpers
      module Autotools
        def define_autotools
          return if action?(:configure)

          sequence :configure, :compile, :install

          action :configure do
            cmd = "sh #{options.configure} --prefix=#{install_path}"
            run cmd, :verbose => options.verbose
          end

          action :compile do
            cmd = "make -f #{options.makefile}"
            run cmd, :verbose => options.verbose
          end

          action :install do
            cmd = "make install -f #{options.makefile}"
            run cmd, :verbose => options.verbose
          end

          after :install do
            cmd = "sh libtool --finish #{install_path('bin')}"
            run cmd, :verbose => options.verbose
          end
        end
      end
    end
  end
end
