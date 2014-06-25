module StartupGenome
  class StoreUser
    include Service 

    attr_reader :user_hash

    def initialize(user_hash)
      @user_hash = user_hash
    end

    def call
      store_user(user_hash)
    end

    private

    def store_user(user_hash)
      data = build_data_hash(user_hash)
      user = User.find_or_initialize_by(startup_genome_slug: user_hash["slug"])
      msg = ""
      msg = user.update!(data) ? "Successfully created/updated #{user_hash['name']}" : "Failed to update #{user_hash['name']}"
      puts msg
      user
    end

    def build_data_hash(user_hash)
      { name: user_hash.fetch("name"),
        startup_genome_image: user_hash.fetch("image"),
        startup_genome_slug: user_hash.fetch("slug"),
        startup_genome_url: user_hash.fetch("url") }
    end
  end
end
