require 'base64'
require 'matrix'
require 'moneta'
require 'moneta/memory'

#APICache.store = Moneta::Memory.new()

Namespaces.register( {:base => "http://example.org/music#"} )
Namespaces.register( {:erco => "http://knowledge.erco.com/properties#"} )
Namespaces.register( {:smw => "http://semantic-mediawiki.org/swivt/1.0#" })
Namespaces.register( {:dbpedia => "http://dbpedia.org/ontology/Person/" })
Namespaces.register( {:wiki => "http://www.medieninformatik.fh-koeln.de/miwiki/Spezial:URIResolver/" })
Namespaces.register( {:aktors => "http://www.aktors.org/ontology/portal#" })
Namespaces.register( {:doap => "http://usefulinc.com/ns/doap#" })
Namespaces.register( {:foaf => "http://xmlns.com/foaf/0.1/" })
Namespaces.register( {:similar => "http://www.serena.com/similar.owl#" })

#TripleManager.timeout=240

SemanticRecord::Base.base = "http://example.org/music#"

#SemanticRecord::Pool.load( File.join(File.dirname(__FILE__), *%w[../triplestores.yml]) )

# SemanticRecord::Pool.register( {:uri => "http://mims03.gm.fh-koeln.de:8282/openrdf-sesame",
#                                 :type => :sesame,
#                                 :default => false,
#                                 :writable => false,
#                                 :repository => "serena" }
#                              )

SemanticRecord::Pool.register( {:uri => "http://192.168.56.1:8080/openrdf-sesame",
                                :type => :sesame,
                                :default => true,
                                :writable => true,
                                :repository => "masterthesis" }
                             )
                             
@@concepts = SemanticRecord::Base.find_by_sparql("SELECT ?result WHERE {?result <http://www.w3.org/2000/01/rdf-schema#subClassOf> <http://www.serena.com/classification.owl#Concept>.}")