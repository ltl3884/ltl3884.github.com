module Jekyll

	class WebPptGenerator < Generator

	  safe true

	  def generate(site)
	    root_path = `pwd`.chop
	    system("nodeppt generate #{root_path}/source/ppts/git_md -a -o #{root_path}/source/ppts/git")
	  end

	end

end