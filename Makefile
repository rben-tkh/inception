NAME			=	inception

RED				=	$'\e[0;31m
GREEN			=	$'\e[32m
BOLD			=	$'\e[1m
UNDER			=	$'\e[4m
END				=	$'\e[0m

VOLUMES_PATH	=	/home/rben-tkh/data/mariadb \
					/home/rben-tkh/data/wordpress

all:
					if test $$(docker-compose -f src/docker-compose.yml images | wc -l) -eq 4; then \
						echo "$(RED) All services are already build$(END)"; \
					else \
						if test -d "/home/rben-tkh/data/mariadb/" && test -d "/home/rben-tkh/data/wordpress/"; then \
							echo "$(RED) Volumes are already created$(END)"; \
						else \
							mkdir -p $(VOLUMES_PATH); \
							echo "$(GREEN) Volumes have been successfully created.$(END)"; \
						fi; \
						docker-compose -f src/docker-compose.yml up -d --build; \
						echo "$(GREEN) All services are ready"; \
						echo " $(BOLD)You can consult the wordpress page using this link -> $(UNDER)rben-tkh.42.fr$(END)"; \
					fi

up:
					if test $$(docker-compose -f src/docker-compose.yml images | wc -l) -ne 4; then \
						echo "$(RED) Containers were not built$(END)"; \
					elif test $$(docker ps | wc -l) -eq 4; then \
						echo "$(RED) All services are already running$(END)"; \
					else \
						docker-compose -f src/docker-compose.yml up -d; \
						echo "$(GREEN) All services are ready$(END)"; \
					fi

stop:
					if test $$(docker ps | wc -l) -eq 1; then \
						echo "$(RED) No service is build or up$(END)"; \
					else \
						docker-compose -f src/docker-compose.yml stop; \
						echo "$(GREEN) All services have been successfully stopped$(END)"; \
					fi

clean:
					if test $$(docker-compose -f src/docker-compose.yml images | wc -l) -eq 1; then \
						echo "$(RED) All services are already removed$(END)"; \
					else \
						docker-compose -f src/docker-compose.yml down; \
						echo "$(GREEN) All services are removed$(END)"; \
					fi

fclean:				clean
					docker system prune -af > /dev/null 2>&1; \
					if test -d "/home/rben-tkh/data/mariadb/" && test -d "/home/rben-tkh/data/wordpress/"; then \
						sudo rm -rf "/home/rben-tkh/data/"; \
						echo "$(GREEN) Volumes have been successfully deleted$(END)"; \
					else \
						echo "$(RED) Volumes are already removed$(END)"; \
					fi

re:					fclean
					make --no-print-directory all

git:
					git add .
					git commit -m "$(NAME)"
					git push -f

.PHONY:				all up stop clean fclean re git
.SILENT:
