# install-argo-rollouts
## Prerequisites
1. ArgoCD 설치
    * install 가이드 : https://github.com/tmax-cloud/install-argocd

## 폐쇄망 구축 가이드
> 아래의 가이드는, 우선적으로 외부 네트워크 통신이 가능한 환경에서 필요한 이미지들을 tar로 다운받고, 해당 tar들을 폐쇄망으로 이동시켜 작업합니다. 

* 작업 디렉토리 생성 및 환경 변수 설정
```
mkdir -p ~/argo-rollouts-install
export ARGO_ROLLOUTS_WORKDIR=~/argo-rollouts-install
```

* 이미지 환경 변수 설정
    * 유의할 점 : latest에 반영된 dex 이미지와 redis 버전 체크.
```
export ARGO_ROLLOUTS_IMG_URL=quay.io/argoproj/argo-rollouts:v1.1.1
```
* 작업 디렉토리로 이동
```
cd $ARGO_ROLLOUTS_WORKDIR
```
* 외부 네트워크 통신이 가능한 환경에서 필요한 이미지 다운로드
```
sudo docker pull ARGO_ROLLOUTS_IMG_URL
sudo docker save ARGO_ROLLOUTS_IMG_URL > argo-rollouts.tar
```
* 레지스트리 환경 변수 설정
```
export REGISTRY=registryip:port
```

* 생성한 이미지 tar 파일을 폐쇄망 환경으로 이동시킨 뒤 사용하려는 registry에 push.
```
sudo docker load < argo-rollouts.tar
sudo docker tag ARGO_ROLLOUTS_IMG_URL ${REGISTRY}/argoproj/argo-rollouts:v1.1.1
sudo docker push ${REGISTRY}/argoproj/argo-rollouts:v1.1.1
```

* 레지스트리에 푸시된 이미지들을 install.yaml에 반영
```
sed -i "s/quay.io/${REGISTRY}/g" install.yaml		 
```

* yaml 설치
```
kubectl apply -f install.yaml
```

## 외부 통신이 가능한 환경에서의 구축 가이드
* yaml 설치
```
kubectl apply -f install.yaml
```
