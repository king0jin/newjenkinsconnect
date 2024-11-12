package naver.et0709.jenkinsconnect;

import org.springframework.stereotype.Service;

@Service
public class JenkinsService {
    public int  hap(int n){
        int result = 0;
        for(int i=1; i<=n; i++){
            result = result + i;
        }
        return result;
    }
}
