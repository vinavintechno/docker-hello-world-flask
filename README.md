# Hello World

Hello world Docker image application for testing.

## Usage

### Run it locally

```shell
$ python3 -m venv venv

$ ./venv/bin/pip install -qr requirements.txt

$ ./venv/bin/python3 server.py
 * Serving Flask app "server" (lazy loading)
 * Environment: production
   WARNING: Do not use the development server in a production environment.
   Use a production WSGI server instead.
 * Debug mode: on
 * Running on http://0.0.0.0:8000/ (Press CTRL+C to quit)
 * Restarting with stat
 * Debugger is active!
 * Debugger PIN: 196-776-054
127.0.0.1 - - [19/Jun/2022 13:07:30] "GET / HTTP/1.1" 200 -
[...]
```

### Build a Docker image

```shell
$ docker build -t datawire/hello-world .
Sending build context to Docker daemon  20.99kB
Step 1/7 : FROM python:3-alpine
 ---> a93594ce93e7
Step 2/7 : WORKDIR /usr/src/app
 ---> Running in 77d72d9f80c7
Removing intermediate container 77d72d9f80c7
 ---> ae6cf20413de
Step 3/7 : EXPOSE 8000
 ---> Running in 19Jun111b3901
Removing intermediate container 19Jun111b3901
 ---> b02c0d3d44cb
Step 4/7 : COPY requirements.txt .
 ---> f78be477ef4c
Step 5/7 : RUN pip install -qr requirements.txt
 ---> Running in 81044c1a701a
Removing intermediate container 81044c1a701a
 ---> f34572dbcf4a
Step 6/7 : COPY server.py .
 ---> 49185ab473c5
Step 7/7 : CMD ["python3", "./server.py"]
 ---> Running in 2446171f3946
Removing intermediate container 2446171f3946
 ---> 7d692d619894
Successfully built 7d692d619894
Successfully tagged datawire/hello-world:latest
```

### Run it in Docker

Build the image first, then launch it using `docker run`.

```shell
$ docker run --rm -it -p 8000:8000 datawire/hello-world
 * Serving Flask app "server" (lazy loading)
 * Environment: production
   WARNING: Do not use the development server in a production environment.
   Use a production WSGI server instead.
 * Debug mode: on
 * Running on http://0.0.0.0:8000/ (Press CTRL+C to quit)
 * Restarting with stat
 * Debugger is active!
 * Debugger PIN: 121-217-524
172.17.0.1 - - [19/Jun/2022 17:04:59] "GET / HTTP/1.1" 200 -
```

### Run it in Kubernetes

Build and push the image first, then launch it using `kubectl run`.

```shell
$ kubectl run hello-world --image=ark3/hello-world --port 8000 --expose
service/hello-world created
deployment.apps/hello-world created

$ kubectl get svc hello-world
NAME          TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
hello-world   ClusterIP   10.3.246.174   <none>        8000/TCP   1m

$ kubectl get deploy,po -l run=hello-world
NAME                                DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
deployment.extensions/hello-world   1         1         1            1           2m

NAME                               READY   STATUS    RESTARTS   AGE
pod/hello-world-776fc969b9-8m457   1/1     Running   0          2m

$ kubectl run curl-from-cluster -it --rm --image=fedora --restart=Never -- curl hello-world:8000
Hello, world!
pod "curl-from-cluster" deleted

$ kubectl logs hello-world-776fc969b9-8m457
 * Serving Flask app "server" (lazy loading)
 * Environment: production
   WARNING: Do not use the development server in a production environment.
   Use a production WSGI server instead.
 * Debug mode: on
 * Running on http://0.0.0.0:8000/ (Press CTRL+C to quit)
 * Restarting with stat
 * Debugger is active!
 * Debugger PIN: 305-616-111
10.0.235.232 - - [19/Jun/2022 17:15:29] "GET / HTTP/1.1" 200 -
```



## License

Licensed under Apache 2.0. Please see [License](LICENSE) for details.
