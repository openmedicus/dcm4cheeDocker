VERSION = 5.14.0
RELEASE = 6

DCM4CHEE_VERSION = 5.14.0-secure
DCM4CHE_VERSION = 5.14.0
KEYCLOAK_VERSION = 4.3.0-14.0
LDAP_VERSION = 2.4.44-14.0

rpm: dcm4chee.spec.in docker-dcm4chee.service docker-keycloak.service docker-ldap.service keycloak.conf ldap.conf dcm4chee.conf
	-rm -rf /tmp/dcm4chee-$(VERSION)
	-rm -f /tmp/dcm4chee-$(VERSION).tar.gz
	mkdir /tmp/dcm4chee-$(VERSION)
	cp dcm4chee.spec.in /tmp/dcm4chee-$(VERSION)/dcm4chee.spec
	sed -i -e 's!@VERSION@!$(VERSION)!g' /tmp/dcm4chee-$(VERSION)/dcm4chee.spec
	sed -i -e 's!@RELEASE@!$(RELEASE)!g' /tmp/dcm4chee-$(VERSION)/dcm4chee.spec
	cp docker-dcm4chee.service /tmp/dcm4chee-$(VERSION)/
	sed -i -e 's!@DOCKER_VERSION@!$(DCM4CHEE_VERSION)!g' /tmp/dcm4chee-$(VERSION)/docker-dcm4chee.service
	cp docker-keycloak.service /tmp/dcm4chee-$(VERSION)/
	sed -i -e 's!@DOCKER_VERSION@!$(KEYCLOAK_VERSION)!g' /tmp/dcm4chee-$(VERSION)/docker-keycloak.service
	cp docker-ldap.service /tmp/dcm4chee-$(VERSION)/
	sed -i -e 's!@DOCKER_VERSION@!$(LDAP_VERSION)!g' /tmp/dcm4chee-$(VERSION)/docker-ldap.service
	cp dcm4chee.conf /tmp/dcm4chee-$(VERSION)/
	cp ldap.conf /tmp/dcm4chee-$(VERSION)/
	cp keycloak.conf /tmp/dcm4chee-$(VERSION)/
	mkdir /tmp/dcm4chee-$(VERSION)/sql
	cp dcm4chee-arc-light/dcm4chee-arc-entity/src/main/resources/sql/create-sqlserver.sql /tmp/dcm4chee-$(VERSION)/sql/create-psql.sql
	cp dcm4chee-arc-light/dcm4chee-arc-entity/src/main/resources/sql/update-*-psql.sql /tmp/dcm4chee-$(VERSION)/sql/
	cp dcm4che.conf /tmp/dcm4chee-$(VERSION)/
	mkdir /tmp/dcm4chee-$(VERSION)/bin
	cp bin/* /tmp/dcm4chee-$(VERSION)/bin/
	sed -i -e 's!@DCM4CHE_VERSION@!$(DCM4CHE_VERSION)!g' /tmp/dcm4chee-$(VERSION)/bin/*
	cd /tmp && tar cfz dcm4chee-$(VERSION).tar.gz dcm4chee-$(VERSION) && cd -
	cd /tmp && rpmbuild -ta /tmp/dcm4chee-$(VERSION).tar.gz

