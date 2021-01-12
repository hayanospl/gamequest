module Posts
  module Postservices

    # module_function

    def self.recommends(current_user)
    

      recommends = current_user.already_reads.order("created_at DESC").limit(30)
      
      array = Array.new
      recommends.each do |reco|
        reco = Post.find_by(id: reco.post_id)
        reco = reco.tag_counts_on(:tags).pluck(:name)
        array.push(reco)
      end

      recommend_tag = array.compact
                          .flatten
                          .group_by{|e| e}
                          .sort_by{|_,v|-v.size}
                          .map(&:first)[0..4]
                          .sample
                          
      @recommend_tag = recommend_tag

      posts = Post.tagged_with(recommend_tag).where.not(user_id: current_user.id)
      @recommend_posts = posts.select('posts.*', 'count(already_reads.id) AS already_reads')
                              .left_joins(:already_reads)
                              .group('posts.id')
                              .order('already_reads desc')
                              .limit(10)
                              .page(params[:page]).per(10)
    end
  end

# module_function :recommends
end
