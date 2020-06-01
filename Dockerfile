FROM golang:1.12.0-alpine3.9
MAINTAINER roberte3@gmail.com 

RUN apk add --nocache git 

ENV LGTM_VERSION=0.1.0

ENV GO111MODULE=on \
    CGO_ENABLED=1


ENV LGTM_NOTE=LGTM \
    LGTM_COUNT=1 \ 
    LGTM_PORT=8989 \ 
    LGTM_TOKEN=fb36357a998062042cb5ddabefd2bdcdbb75df84b6f84d29abdfd9e08776568d \
    LGTM_GITLAB_URL=localhost:80 \
    LGTM_DB_PATH=/var/lib/lgtm/lgtm.data \
    LGTM_LOG_LEVEL=info

VOLUME /var/lib/lgtm
EXPOSE 8989

RUN git clone https://github.com/roberte3/lgtm-gitlab
WORKDIR lgtm-gitlab
RUN go mod download 
RUN go build  


CMD ["ls"]
CMD ["sh", "-c",\
    "./lgtm-gitlab -token $LGTM_TOKEN -gitlab_url $LGTM_GITLAB_URL -lgtm_count $LGTM_COUNT -lgtm_note $LGTM_NOTE -log_level $LGTM_LOG_LEVEL -db_path $LGTM_DB_PATH -port $LGTM_PORT"\
]
