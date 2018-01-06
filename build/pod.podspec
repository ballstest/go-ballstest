Pod::Spec.new do |spec|
  spec.name         = 'ballstest'
  spec.version      = '{{.Version}}'
  spec.license      = { :type => 'GNU Lesser General Public License, Version 3.0' }
  spec.homepage     = 'https://github.com/ballstest/go-ballstest'
  spec.authors      = { {{range .Contributors}}
		'{{.Name}}' => '{{.Email}}',{{end}}
	}
  spec.summary      = 'iOS ballstest Client'
  spec.source       = { :git => 'https://github.com/ballstest/go-ballstest.git', :commit => '{{.Commit}}' }

	spec.platform = :ios
  spec.ios.deployment_target  = '9.0'
	spec.ios.vendored_frameworks = 'Frameworks/ballstest.framework'

	spec.prepare_command = <<-CMD
    curl https://ballsteststore.blob.core.windows.net/builds/{{.Archive}}.tar.gz | tar -xvz
    mkdir Frameworks
    mv {{.Archive}}/ballstest.framework Frameworks
    rm -rf {{.Archive}}
  CMD
end
