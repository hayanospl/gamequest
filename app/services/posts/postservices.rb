module Posts
  module Postservices

    def self.recommend_tag(current_user)
    

      recommends = current_user.already_reads.order("created_at DESC").limit(30)
      
      array = Array.new
      recommends.each do |reco|
        reco = Post.find_by(id: reco.post_id)
        reco = reco.tag_counts_on(:tags).pluck(:name)
        array.push(reco)
      end

      return array.compact
                  .flatten
                  .group_by{|e| e}
                  .sort_by{|_,v|-v.size}
                  .map(&:first)[0..4]
                  .sample
    end

    def self.recommend_posts(current_user, recommend_tag, params)
      posts = Post.tagged_with(recommend_tag).where.not(user_id: current_user.id)
      return posts.select('posts.*', 'count(already_reads.id) AS already_reads')
                              .left_joins(:already_reads)
                              .group('posts.id')
                              .order('already_reads desc')
                              .limit(10)
                              .page(params[:page]).per(10)
    end

    def self.search(params)
      posts = Post.includes(:user, :taggings).where('title LIKE ? OR content LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%") if params[:keyword].present?
      if params[:tag_name].present? && params[:keyword].present?
        posts = posts.tagged_with(params[:tag_name], :match_all => false)
      elsif params[:tag_name].present?
        posts = Post.includes(:user, :taggings).tagged_with(params[:tag_name], :match_all => false)
      end
  
      if params[:tag_name].blank? && params[:keyword].blank?
        posts = Post.all.includes(:user, :taggings)
      end
  
      case params[:sort]
  
        when 'new'
          posts = posts.order(created_at: :DESC)
          
        when 'old'
          posts = posts.order(created_at: :ASC)
          
        when 'likes'
          posts = posts.select('posts.*', 'count(likes.id) AS likes')
                        .left_joins(:likes)
                        .group('posts.id')
                        .order('likes desc')
                        .order('created_at desc')
                        
        when 'dislikes'
          posts = posts.select('posts.*', 'count(likes.id) AS likes')
                        .left_joins(:likes)
                        .group('posts.id')
                        .order('likes asc')
                        .order('created_at desc')
      end
  
      if params[:likecount].present?
        post_array = Array.new
  
        case params[:inequality]
  
          when 'greater'
            posts.each do |p|
              if p.likes.count >= params[:likecount].to_i
                post_array.push(p)
              end
            end
          posts = post_array
  
          when 'less'
            posts.each do |p|
              if p.likes.count <= params[:likecount].to_i
                post_array.push(p)
              end
            end
          posts = post_array
        end
  
      end
  
      return Kaminari.paginate_array(posts).page(params[:page]).per(10) unless posts.blank?
      return Post.none if posts.blank?

    end
  end
end