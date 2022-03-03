const fs = require('fs');

const valorizeTmpl = str => {

	return str.replace(/\$\{([\w_\-]+)\}/g, (str, key) => {
		return process.env[key] || '';
	});	
}

const sets = valorizeTmpl( fs.readFileSync(process.argv[2],'utf-8') );

process.stdout.write( JSON.stringify(JSON.parse(sets)) );
