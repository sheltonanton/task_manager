class Singleton
    @object_instance = new

    private_class_method :new

    # class method instance to get the singlton instance
    def self.instance
        @object_instance
    end
end