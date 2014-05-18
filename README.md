rdfsTranslator
==============

This is a basic __Ruby__ script which is translating simple sentences written in English to the __RDF Schema__ file.  

Installation Guide
---------
To use this script you must have Ruby(was written using 2.1.1) installed on your computer. What is more, this script requires some gems to work properly. Here is the list of dependencies:
+ `active_support`
+ `linguistics`
+ `rspec` and `fakefs` if you'd like to run tests

Usage
-------
If your environment has everything installed and setup you have to run a basic command in your shell:  

    $ruby rdfst input_file.txt output_file.rdf

That's all... Now you have an `output_file.rdf` with schema on your disk!

Input and output
--------
Input file is a text file with english sentences which you want to convert into RDF Schema. Each sentence should be in another line. Check out the example below:

    Sudent is a human.
    Student has name.
    Teacher teaches student.
    Teacher has an email.

And if your run __rdfst__ on a file like this you'll get in result:

    <?xml version='1.0'?>
    <!DOCTYPE rdf:RDF [<!ENTITY rdf "http://www.w3.org/1999/02/22-rdf-syntax-ns#">]>
    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
             xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#">


    <!-- Classes -->

    <rdfs:Class rdf:about="human"></rdfs:Class>
    <rdfs:Class rdf:about="student"></rdfs:Class>
    <rdfs:Class rdf:about="teacher"></rdfs:Class>

    <!-- Subclasses -->

    <rdfs:Class rdf:about="sudent">
                <rdfs:subClassOf rdf:resource="#human"/>
    </rdfs:Class>

    <!-- Relations -->

    <rdfs:Property rdf:about="#teaches">
            <rdfs:domain rdf:resource="#teacher"/>
            <rdfs:range rdf:resource="#student"/>
    </rdfs:Property>

    <!-- Properties -->

    <rdfs:Property rdf:about="#name">
            <rdfs:domain rdf:resource="#student"/>
            <rdfs:range rdf:resource="&rdf;Literal"/>
    </rdfs:Property>
    <rdfs:Property rdf:about="#email">
            <rdfs:domain rdf:resource="#teacher"/>
            <rdfs:range rdf:resource="&rdf;Literal"/>
    </rdfs:Property>

    </rdf:RDF>

Authors
-------
[rdzieza](https://github.com/rdzieza)
[@cojoj](https://twitter.com/cojoj)

License
---------
rdfsTranslator is available under the MIT license. See the LICENSE file for more info.

