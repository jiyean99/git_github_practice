# ==========================================
# env_settings 치트시트 (Git 기본 환경 & 워크플로우)
# ==========================================

# ------------------------------------------
# 1. 기본 Git 워크플로우
# ------------------------------------------
git add .                     # 변경사항 전부를 Staging Area 로 이동
git add path/to/file          # 특정 파일만 추가

git commit -m "메시지"        # Staging → 커밋, commit ID 생성, 이력 남김
git push origin main          # 로컬 main 브랜치를 원격 origin 으로 푸시


# ------------------------------------------
# 2. 사용자 정보 / 설정
# ------------------------------------------
git config --list             # 현재 git 설정 전체 조회
git config --global user.name "이름"
git config --global user.email "이메일"


# ------------------------------------------
# 3. 인증 방식 개념 (요약)
# ------------------------------------------
# - GitHub 웹 로그인 → 브라우저 인증 후 토큰 간접 발급
# - Personal Access Token 직접 발급 → 비밀번호 대신 토큰 사용
#   (토큰은 비밀번호와 동일 수준의 민감정보이므로 .gitignore 등으로 절대 노출 금지)


# ------------------------------------------
# 4. Git 프로젝트 생성 2가지 패턴
# ------------------------------------------
# 4-1) 회사/팀 레포 먼저 존재 → clone 후 작업
git clone https://github.com/org/project.git
cd project
# ... 작업 후
git add .
git commit -m "작업 내용"
git push origin main

# 4-2) 로컬에서 먼저 프로젝트 진행 → 나중에 원격에 올리기
cd my-local-project
git init                                  # .git 폴더 생성 (위치 중요)
git remote add origin https://github.com/me/my-repo.git
git branch                                # 현재 브랜치 확인 (보통 master)
git checkout -b main                      # main 브랜치 생성 + 이동
git add .
git commit -m "초기 커밋"
git push origin main                      # 원격 main 최초 푸시


# ------------------------------------------
# 5. 다른 사람 레포를 내 레포로 가져오기 (이력 유지)
# ------------------------------------------
git clone https://github.com/other/repo.git
cd repo
git remote set-url origin https://github.com/me/my-repo.git   # 원격지 변경
git branch                                                    # main 브랜치인지 확인
git push origin main                                          # 기존 커밋 이력 그대로 푸시


# ------------------------------------------
# 6. 다른 사람 레포를 이력 없이 가져오기 (새 이력 시작)
# ------------------------------------------
git clone https://github.com/other/repo.git
cd repo

rm -rf .git                          # 기존 이력/원격 완전 제거 (주의)
git init
git remote add origin https://github.com/me/my-repo.git
git checkout -b main                 # main 브랜치 생성
git branch                           # main 인지 확인
git add .
git commit -m "초기 커밋 (새 이력)"
git push origin main


# ------------------------------------------
# 7. 원격 주소 변경 (remote 변경)
# ------------------------------------------
git remote set-url origin https://github.com/me/new-repo.git


# ------------------------------------------
# 8. .git 폴더 개념
# ------------------------------------------
# - .git/ : 원격 정보, 브랜치, 커밋 이력 등 git 전부가 들어있는 메타데이터 디렉터리
# - 삭제하면 "git 관리가 해제"되며, 다시 git init 으로 새로 만들 수 있지만
#   이전 커밋 이력은 모두 사라짐


# ------------------------------------------
# 9. .gitignore & 캐시 제거
# ------------------------------------------
# .gitignore : 추적 제외할 파일/폴더 목록
#  - 빌드 산출물, 민감정보(.env, 키, 토큰 등) 등은 반드시 제외
#
# 이미 추적 중인 파일을 .gitignore 에 추가한 경우, 캐시 제거 필요:
git rm -r --cached .                 # 인덱스(캐시)에서 모두 제거
git add .                            # 다시 추가 (이때 .gitignore 적용)
git commit -m "Update .gitignore"    # 변경사항 커밋
