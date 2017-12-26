mkdir -p plugins; cd plugins
apt install unzip -y

#scrum ( https://redmine.ociotec.com/projects/redmine-plugin-scrum )
curl -o scrum.tar.gz https://redmine.ociotec.com/attachments/download/470/scrum-v0.17.0.tar.gz;\
        tar xvf scrum.tar.gz;rm scrum.tar.gz;
# patch date type callendar
sed -i 's/text\(_field.*date*\)/date\1/g' scrum/app/views/sprints/_form.html.erb
sed -i 's/text\(_field.*date*\)/date\1/g' scrum/app/views/scrum/_issue_attributes.html.erb

#git clone https://github.com/RCRM/redmine_agile

#git clone https://framagit.org/infopiiaf/redhopper
#gem install resort


#jenkins
#git clone https://github.com/jbox-web/redmine_bootstrap_kit;cd redmine_bootstrap_kit;git checkout 0.2.5;cd ..
#git clone https://github.com/jbox-web/redmine_jenkins;cd redmine_jenkins; git checkout 1.0.1;cd ..

# code review
#hg pull https://bitbucket.org/haru_iida/redmine_code_review

# clipboard_image_paste
#git clone https://github.com/peclik/clipboard_image_paste

# # excel
# git clone https://github.com/two-pack/redmine_xls_export redmine_xls_export
# git clone https://github.com/javiferrer/redmine_import_issues

#pivottable
#git clone https://github.com/deecay/redmine_pivot_table

# # wiki html util ( https://github.com/mexitek/redmine_wiki_html_util ) {{html() }
# git clone git://github.com/mexitek/redmine_wiki_html_util

# graphviz
#git clone git://github.com/tckz/redmine-wiki_graphviz_plugin wiki_graphviz_plugin

# plantuml
git clone https://github.com/dkd/plantuml
sed -i 's/requires_redmine.*/requires_redmine :version_or_higher => "2.6"/' plantuml/init.rb
curl -o plantuml/plantuml.jar http://jaist.dl.sourceforge.net/project/plantuml/plantuml.jar
curl -o plantuml/plantuml-jlatexmath.zip https://dl.dropboxusercontent.com/u/13064071/plantuml-jlatexmath.zip;unzip plantuml/plantuml-jlatexmath -d plantuml; rm plantuml/plantuml-jlatexmath.zip
echo '#!/bin/bash' >> plantuml/plantuml
echo 'java -cp /usr/src/redmine/plugins/plantuml/. -Djava.io.tmpdir=/var/tmp -Djava.awt.headless=true -jar /usr/src/redmine/plugins/plantuml/plantuml.jar ${@}' >> plantuml/plantuml
#echo 'java -cp . -Djava.io.tmpdir=/var/tmp -Djava.awt.headless=true -jar plantuml.jar ${@}' >> plantuml/plantuml
chmod a+x plantuml/plantuml
cp plantuml/plantuml /usr/bin/plantuml

#git clone https://github.com/dergachev/redmine_gist

#git clone https://github.com/stgeneral/redmine-progressive-projects-list progressive_projects_list

#redmine_tweak
#git clone https://github.com/alexandermeindl/redmine_tweaks

# curl -o localizable.tar.gz https://redmine.ociotec.com/attachments/download/330/localizable%200.4.0.tar.gz;\
# 	tar xvf localizable.tar.gz;mv "localizable 0.4.0" localizable;rm localizable.tar.gz;

#git clone https://github.com/mrcage/wiking

#git clone https://github.com/braini75/msproject_import

# git clone https://github.com/Loriowar/redmine_issues_tree

#svn checkout svn://svn.code.sf.net/p/projectstreeview/code/trunk projectstreeview

cd ..
